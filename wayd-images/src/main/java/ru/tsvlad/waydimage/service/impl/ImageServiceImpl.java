package ru.tsvlad.waydimage.service.impl;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifIFD0Directory;
import io.minio.GetPresignedObjectUrlArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import io.minio.http.Method;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.imgscalr.Scalr;
import org.springframework.http.codec.multipart.FilePart;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.tsvlad.waydimage.commons.ImageIdToUrl;
import ru.tsvlad.waydimage.commons.UserInfo;
import ru.tsvlad.waydimage.config.props.ImageProperties;
import ru.tsvlad.waydimage.config.security.Role;
import ru.tsvlad.waydimage.document.ImageDocument;
import ru.tsvlad.waydimage.enums.ImageStatus;
import ru.tsvlad.waydimage.messaging.consumer.msg.dto.ModeratorDecision;
import ru.tsvlad.waydimage.messaging.consumer.msg.dto.Validity;
import ru.tsvlad.waydimage.messaging.producer.ImageServiceProducer;
import ru.tsvlad.waydimage.repository.ImageRepository;
import ru.tsvlad.waydimage.restapi.controller.advise.exceptions.BadImageException;
import ru.tsvlad.waydimage.restapi.controller.advise.exceptions.ServerException;
import ru.tsvlad.waydimage.restapi.dto.ImageNamesDTO;
import ru.tsvlad.waydimage.service.ImageService;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
@Slf4j
public class ImageServiceImpl implements ImageService {

    private final ImageProperties imageProperties;

    private final ImageServiceProducer imageServiceProducer;

    private final MinioClient minioClient;

    private final ImageRepository imageRepository;

    @Override
    public Flux<ImageDocument> saveImages(Flux<FilePart> fileParts, UserInfo userInfo) {
        return fileParts.flatMap(fp -> fp.content()
                .flatMap(buffer -> Flux.just(buffer.asByteBuffer().array()))
                .collectList()
                .map(this::byteArrayListToByteArray)
                .flatMap(bytes -> {
                    BufferedImage image = getImageFromBytes(bytes);
                    return saveImage(image, userInfo.getId());
                }));
    }

    @Override
    public Flux<ImageIdToUrl> getImageUrls(List<String> ids, boolean isMiniature, List<Role> userRoles, String userId) {
        Flux<ImageIdToUrl> result = Flux.empty();
        for (String id : ids) {
            result = Flux.concat(result, getImageUrl(id, isMiniature, userRoles, userId));
        }
        return result;
    }


    @Override
    public Mono<ImageIdToUrl> getImageUrl(String id, boolean isMiniature, List<Role> userRoles, String userId) {
        return imageRepository.findById(id)
                .flatMap(imageDocument -> {
                    if (imageDocument.getStatus() == ImageStatus.ACTIVE || userRoles.contains(Role.ROLE_MODERATOR)
                            || imageDocument.getOwnerId().equals(userId)) {
                        return Mono.just(ImageIdToUrl.builder()
                                        .id(id)
                                        .url(getUrlFromMinio(isMiniature ? imageDocument.getMiniatureName() : imageDocument.getName()))
                                .build());

                    }
                    return Mono.empty();
                });
    }

    @Override
    public void updateImageValidity(String id, Validity validity) {
        imageRepository.findById(id)
                .flatMap(imageDocument -> {
                    imageDocument.validate(validity);
                    return imageRepository.save(imageDocument);
                }).doOnNext(imageDocument -> {
                    if (imageDocument.getValidity() == Validity.NOT_VALID) {
                        imageServiceProducer.invalidImage(imageDocument);
                    }
                })
                .subscribe();
    }

    @Override
    public Mono<ImageDocument> blockImage(String imageId) {
        return imageRepository.findById(imageId)
                .flatMap(imageDocument -> {
                    imageDocument.setStatus(ImageStatus.BLOCKED_BY_MODERATOR);
                    return imageRepository.save(imageDocument);
                });
    }

    private String getUrlFromMinio(String objectName) {
        try {
            return minioClient.getPresignedObjectUrl(GetPresignedObjectUrlArgs.builder()
                    .method(Method.GET)
                    .expiry(10, TimeUnit.MINUTES)
                    .bucket(imageProperties.getBucket())
                    .object(objectName)
                    .build());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    private byte[] byteArrayListToByteArray(List<byte[]> list) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        list.forEach(byteArrayOutputStream::writeBytes);
        return byteArrayOutputStream.toByteArray();
    }

    private BufferedImage getImageFromBytes(byte[] bytes) {
        InputStream inputStream = new ByteArrayInputStream(bytes);
        BufferedImage image;
        try {
            image = getImageFromInputStream(inputStream);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BadImageException();
        }
        return image;
    }

    private BufferedImage getImageFromInputStream(InputStream imageInputStream) throws MetadataException, ImageProcessingException, IOException {
        Metadata metadata = ImageMetadataReader.readMetadata(imageInputStream);

        imageInputStream.reset();
        BufferedImage image = ImageIO.read(imageInputStream);

        ExifIFD0Directory exifIFD0 = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);
        if (exifIFD0 != null) {
            int orientation = exifIFD0.getInt(ExifIFD0Directory.TAG_ORIENTATION);
            if (image == null) {
                throw new BadImageException();
            }
            image = rotateImageIfNeed(image, orientation);
        }

        image = resizeImageIfNeed(image, imageProperties.getMaxSize());

        return image;
    }

    private BufferedImage rotateImageIfNeed(BufferedImage image, int orientation) {
        switch (orientation) {
            case 1:
                return image;
            case 6:
                return Scalr.rotate(image, Scalr.Rotation.CW_90);
            case 3:
                return Scalr.rotate(image, Scalr.Rotation.CW_180);
            case 8:
                return Scalr.rotate(image, Scalr.Rotation.CW_270);
        }
        return image;
    }

    private Mono<ImageDocument> saveImage(BufferedImage image, String userId) {
        String uuidName = UUID.randomUUID().toString();
        String dir = "" + userId + "/";
        String fullName = dir + uuidName + ".jpg";
        String smallName = dir + uuidName + "-small.jpg";

        ImageNamesDTO imageNamesDTO = ImageNamesDTO.builder()
                .fullName(fullName)
                .smallName(smallName)
                .build();

        try {
            saveInMinio(image, fullName);
            saveInMinio(getSmallImage(image), smallName);

            return saveInDb(fullName, smallName, userId)
                    .doOnNext(img -> {
                        try {
                            imageServiceProducer.newImage(getBytesFromBufferedImage(resizeImageIfNeed(image, 300)), img);
                        } catch (Exception e) {
                            throw new ServerException(e);
                        }
                    })
                    .onErrorMap(e -> {
                        log.error("Error while saving image: {}", e.getMessage());
                        return new ServerException("Server error");
                    });
        } catch (Exception e) {
            log.error("Error while saving image: {}", e.getMessage());
            return Mono.error(new ServerException("Server error"));
        }
    }

    private Mono<ImageDocument> saveInDb(String name, String miniatureName, String userId) {
        return imageRepository.save(ImageDocument.createNewImage(name, miniatureName, userId));
    }

    private void saveInMinio(BufferedImage image, String name) throws Exception {
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        ImageIO.write(image, "jpg", os);
        InputStream is = new ByteArrayInputStream(os.toByteArray());
        minioClient.putObject(PutObjectArgs.builder()
                .bucket(imageProperties.getBucket())
                .stream(is, -1, 10485760)
                .contentType("image/jpg")
                .object(name)
                .build());
    }

    private byte[] getBytesFromBufferedImage(BufferedImage image) throws Exception{
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        ImageIO.write(image, "jpg", os);
        return os.toByteArray();
    }

    private BufferedImage getSmallImage(BufferedImage image) {
        return resizeImageIfNeed(image, imageProperties.getSmallMaxSize());
    }

    private BufferedImage resizeImageIfNeed(BufferedImage image, int maxSize) {
        double yScale = (maxSize + 0.0) / image.getHeight();
        double xScale = (maxSize + 0.0) / image.getWidth();

        double scale = Math.min(xScale, yScale);
        if (scale < 1) {
            return Scalr.resize(image, (int) (image.getWidth() * scale), (int) (image.getHeight() * scale));
        }
        return image;
    }
}
