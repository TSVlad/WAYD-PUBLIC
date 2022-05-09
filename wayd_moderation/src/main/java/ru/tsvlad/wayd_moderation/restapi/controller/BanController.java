package ru.tsvlad.wayd_moderation.restapi.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.common.BanCreation;
import ru.tsvlad.wayd_moderation.restapi.dto.BanCreationDTO;
import ru.tsvlad.wayd_moderation.restapi.dto.BanDTO;
import ru.tsvlad.wayd_moderation.service.AuthenticationService;
import ru.tsvlad.wayd_moderation.service.BanService;

import javax.validation.Valid;

@RestController
@RequestMapping("/ban")
@AllArgsConstructor
@Slf4j
public class BanController {
    private final BanService banService;
    private final AuthenticationService authenticationService;

    private final ModelMapper modelMapper;

    @PostMapping
    @PreAuthorize("hasRole('ROLE_MODERATOR')")
    public Mono<BanDTO> banUser(@Valid  @RequestBody BanCreationDTO banCreationDTO, Authentication  authentication) {
        log.debug("Ban user request gotten: {}", banCreationDTO);
        BanCreation banCreation = modelMapper.map(banCreationDTO, BanCreation.class);
        banCreation.setModeratorId(authenticationService.getUserId(authentication));
        return banService.banUser(banCreation).map(banDocument -> modelMapper.map(banDocument, BanDTO.class));
    }
}
