package ru.tsvlad.waydimage.restapi.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.http.MediaType;
import org.springframework.http.codec.multipart.FilePart;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.tsvlad.waydimage.commons.UserInfo;
import ru.tsvlad.waydimage.document.ImageDocument;
import ru.tsvlad.waydimage.restapi.dto.ImageIdToUrlDTO;
import ru.tsvlad.waydimage.service.AuthenticationService;
import ru.tsvlad.waydimage.service.ImageService;

import java.util.List;

@RestController
@RequestMapping("/image")
@AllArgsConstructor
@Slf4j
public class ImagesController {

    private final ImageService imageService;
    private final AuthenticationService authenticationService;

    private final ModelMapper modelMapper;

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public Mono<List<String>> saveImages(@RequestPart(name = "files") Flux<FilePart> parts, Authentication authentication) {
        log.debug("Save image request gotten");
        return imageService.saveImages(parts, authenticationService.getUserInfo(authentication))
                .map(ImageDocument::getId).collectList();
    }

    @GetMapping("/{id}")
    public Mono<ImageIdToUrlDTO> getImageUrl(@PathVariable String id, @RequestParam("miniature") boolean isMiniature,
                                             Authentication authentication) {
        log.debug("Get image url request gotten for image id {}", id);
        UserInfo userInfo = authenticationService.getUserInfo(authentication);
        return imageService.getImageUrl(id, isMiniature, userInfo.getRoles(), userInfo.getId())
                .map(imageIdToUrl -> modelMapper.map(imageIdToUrl, ImageIdToUrlDTO.class));
    }

    @GetMapping
    public Flux<ImageIdToUrlDTO> getImageUrls(@RequestParam(name = "id") List<String> ids,
                                              @RequestParam("miniature") boolean isMiniature,
                                              Authentication authentication) {
        log.debug("Get images urls request gotten for ids {}", ids);
        log.info("Auth: {}", authentication);
        UserInfo userInfo = authenticationService.getUserInfo(authentication);
        return imageService.getImageUrls(ids, isMiniature, userInfo.getRoles(), userInfo.getId())
                .map(imageIdToUrl -> modelMapper.map(imageIdToUrl, ImageIdToUrlDTO.class));
    }
}
