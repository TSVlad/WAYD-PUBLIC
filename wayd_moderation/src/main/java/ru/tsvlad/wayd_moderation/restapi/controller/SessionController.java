package ru.tsvlad.wayd_moderation.restapi.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.restapi.dto.SessionDTO;
import ru.tsvlad.wayd_moderation.service.AuthenticationService;
import ru.tsvlad.wayd_moderation.service.SessionService;

@RestController
@RequestMapping("/session")
@AllArgsConstructor
@Slf4j
public class SessionController {

    private final SessionService sessionService;
    private final AuthenticationService authenticationService;

    private final ModelMapper modelMapper;

    @PostMapping("/start")
    @PreAuthorize("hasRole('ROLE_MODERATOR')")
    public Mono<SessionDTO> startSession(Authentication authentication) {
        log.debug("Start session request gotten");
        return sessionService.startSession(authenticationService.getUserId(authentication))
                .map(sessionDocument -> modelMapper.map(sessionDocument, SessionDTO.class));
    }

    @PostMapping("/close")
    @PreAuthorize("hasRole('ROLE_MODERATOR')")
    public Mono<SessionDTO> closeSession(Authentication authentication) {
        log.debug("Close session request gotten");
        return sessionService.closeSession(authenticationService.getUserId(authentication))
                .map(sessionDocument -> modelMapper.map(sessionDocument, SessionDTO.class));
    }

    @GetMapping("/current")
    @PreAuthorize("hasRole('ROLE_MODERATOR')")
    public Mono<SessionDTO> getCurrentSession(Authentication authentication) {
        log.debug("Get currant session request gotten");
        return sessionService.getCurrentSession(authenticationService.getUserId(authentication))
                .map(sessionDocument ->  modelMapper.map(sessionDocument, SessionDTO.class));
    }
}
