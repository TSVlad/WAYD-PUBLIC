package ru.tsvlad.waydimage.service;

import org.springframework.http.codec.multipart.FilePart;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.tsvlad.waydimage.commons.ImageIdToUrl;
import ru.tsvlad.waydimage.commons.UserInfo;
import ru.tsvlad.waydimage.config.security.Role;
import ru.tsvlad.waydimage.document.ImageDocument;
import ru.tsvlad.waydimage.messaging.consumer.msg.dto.ModeratorDecision;
import ru.tsvlad.waydimage.messaging.consumer.msg.dto.Validity;

import java.util.List;

public interface ImageService {
    Flux<ImageDocument> saveImages(Flux<FilePart> fileParts, UserInfo userInfo);
    Flux<ImageIdToUrl> getImageUrls(List<String> ids, boolean isMiniature, List<Role> userRoles, String userId);
    Mono<ImageIdToUrl> getImageUrl(String id, boolean isMiniature, List<Role> userRoles, String userId);
    void updateImageValidity(String id, Validity validity);
    Mono<ImageDocument> blockImage(String imageId);
}
