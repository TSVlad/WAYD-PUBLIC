package ru.tsvlad.waydimage.service.impl;

import io.minio.MinioClient;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;
import ru.tsvlad.waydimage.BaseIntegrationTest;
import ru.tsvlad.waydimage.commons.ImageIdToUrl;
import ru.tsvlad.waydimage.config.security.Role;
import ru.tsvlad.waydimage.document.ImageDocument;
import ru.tsvlad.waydimage.enums.ImageStatus;
import ru.tsvlad.waydimage.messaging.consumer.msg.dto.Validity;
import ru.tsvlad.waydimage.messaging.producer.ImageServiceProducer;
import ru.tsvlad.waydimage.repository.ImageRepository;

import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@SpringBootTest
class ImageServiceImplTest extends BaseIntegrationTest {

    @Autowired
    ImageServiceImpl imageService;

    @MockBean
    ImageRepository imageRepository;
    @MockBean
    MinioClient minioClient;
    @MockBean
    ImageServiceProducer imageServiceProducer;

    @Test
    void getImageUrlTest() throws Exception{
        ImageDocument imageDocument = ImageDocument.builder()
                .id("1")
                .miniatureName("minname1")
                .name("name1")
                .ownerId("1")
                .status(ImageStatus.ACTIVE)
                .validity(Validity.VALID)
                .build();
        ImageIdToUrl imageIdToUrl = new ImageIdToUrl("1", "url");

        when(imageRepository.findById("1")).thenReturn(Mono.just(imageDocument));
        when(minioClient.getPresignedObjectUrl(any())).thenReturn("url");

        StepVerifier.create(imageService.getImageUrl("1", false,
                List.of(Role.ROLE_USER,  Role.ROLE_PERSON), "2"))
                .expectNext(imageIdToUrl)
                .verifyComplete();
    }

    @Test
    void getImageUrlNonActiveTest() throws Exception{
        ImageDocument imageDocument = ImageDocument.builder()
                .id("1")
                .miniatureName("minname1")
                .name("name1")
                .ownerId("1")
                .status(ImageStatus.BANNED)
                .validity(Validity.VALID)
                .build();

        when(imageRepository.findById("1")).thenReturn(Mono.just(imageDocument));

        StepVerifier.create(imageService.getImageUrl("1", false,
                        List.of(Role.ROLE_USER,  Role.ROLE_PERSON), "2"))
                .verifyComplete();
    }

    @Test
    void getImageUrlNonActiveModeratorTest() throws Exception{
        ImageDocument imageDocument = ImageDocument.builder()
                .id("1")
                .miniatureName("minname1")
                .name("name1")
                .ownerId("1")
                .status(ImageStatus.BANNED)
                .validity(Validity.VALID)
                .build();
        ImageIdToUrl imageIdToUrl = new ImageIdToUrl("1", "url");

        when(imageRepository.findById("1")).thenReturn(Mono.just(imageDocument));
        when(minioClient.getPresignedObjectUrl(any())).thenReturn("url");

        StepVerifier.create(imageService.getImageUrl("1", false,
                        List.of(Role.ROLE_USER,  Role.ROLE_PERSON, Role.ROLE_MODERATOR), "2"))
                .expectNext(imageIdToUrl)
                .verifyComplete();
    }

    @Test
    void updateImageValidityValidTest() {
        ImageDocument imageDocument = ImageDocument.builder()
                .id("1")
                .miniatureName("minname1")
                .name("name1")
                .ownerId("1")
                .status(ImageStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .build();
        ImageDocument imageDocumentAfter = ImageDocument.builder()
                .id("1")
                .miniatureName("minname1")
                .name("name1")
                .ownerId("1")
                .status(ImageStatus.ACTIVE)
                .validity(Validity.VALID)
                .build();

        when(imageRepository.findById("1")).thenReturn(Mono.just(imageDocument));

        imageService.updateImageValidity("1", Validity.VALID);

        verify(imageRepository).save(imageDocumentAfter);
    }

    @Test
    void updateImageValidityInvalidTest() {
        ImageDocument imageDocument = ImageDocument.builder()
                .id("1")
                .miniatureName("minname1")
                .name("name1")
                .ownerId("1")
                .status(ImageStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .build();
        ImageDocument imageDocumentAfter = ImageDocument.builder()
                .id("1")
                .miniatureName("minname1")
                .name("name1")
                .ownerId("1")
                .status(ImageStatus.ON_MODERATION)
                .validity(Validity.NOT_VALID)
                .build();

        when(imageRepository.findById("1")).thenReturn(Mono.just(imageDocument));
        when(imageRepository.save(imageDocumentAfter)).thenReturn(Mono.just(imageDocumentAfter));

        imageService.updateImageValidity("1", Validity.NOT_VALID);

        verify(imageServiceProducer).invalidImage(imageDocumentAfter);
    }

    @Test
    void blockImage() {
        ImageDocument imageDocument = ImageDocument.builder()
                .id("1")
                .miniatureName("minname1")
                .name("name1")
                .ownerId("1")
                .status(ImageStatus.ON_MODERATION)
                .validity(Validity.NOT_VALID)
                .build();
        ImageDocument imageDocumentAfter = ImageDocument.builder()
                .id("1")
                .miniatureName("minname1")
                .name("name1")
                .ownerId("1")
                .status(ImageStatus.BLOCKED_BY_MODERATOR)
                .validity(Validity.NOT_VALID)
                .build();

        when(imageRepository.findById("1")).thenReturn(Mono.just(imageDocument));
        when(imageRepository.save(imageDocumentAfter)).thenReturn(Mono.just(imageDocumentAfter));

        StepVerifier.create(imageService.blockImage("1"))
                .expectNext(imageDocumentAfter)
                .verifyComplete();
    }

    @Test
    void getImageUrlsTest() throws Exception{
        List<ImageDocument> imageDocuments = List.of(
                ImageDocument.builder()
                        .id("1")
                        .miniatureName("minname1")
                        .name("name1")
                        .ownerId("1")
                        .status(ImageStatus.ACTIVE)
                        .validity(Validity.VALID)
                        .build(),
                ImageDocument.builder()
                        .id("2")
                        .miniatureName("minname2")
                        .name("name2")
                        .ownerId("2")
                        .status(ImageStatus.ON_VALIDATION)
                        .validity(Validity.NOT_VALIDATED)
                        .build(),
                ImageDocument.builder()
                        .id("3")
                        .miniatureName("minname3")
                        .name("name3")
                        .ownerId("3")
                        .status(ImageStatus.ACTIVE)
                        .validity(Validity.VALID)
                        .build()
        );
        List<ImageIdToUrl> expectedResult = List.of(new ImageIdToUrl("1", "url1"),
                new ImageIdToUrl("3", "url2")
        );

        when(imageRepository.findById("1")).thenReturn(Mono.just(imageDocuments.get(0)));
        when(imageRepository.findById("2")).thenReturn(Mono.just(imageDocuments.get(1)));
        when(imageRepository.findById("3")).thenReturn(Mono.just(imageDocuments.get(2)));
        when(minioClient.getPresignedObjectUrl(any())).thenReturn("url1", "url2");

        StepVerifier.create(imageService.getImageUrls(List.of("1", "2", "3"), false,
                List.of(Role.ROLE_USER, Role.ROLE_PERSON), "4"))
                .expectNextSequence(expectedResult)
                .verifyComplete();
    }
}