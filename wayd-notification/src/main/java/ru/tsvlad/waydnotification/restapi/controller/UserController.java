package ru.tsvlad.waydnotification.restapi.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import ru.tsvlad.waydnotification.service.AuthenticationService;
import ru.tsvlad.waydnotification.service.UserService;

@RestController
@RequestMapping("/user")
@AllArgsConstructor
@Slf4j
public class UserController {

    private final UserService userService;
    private final AuthenticationService authenticationService;

    @GetMapping("/send-email")
    public boolean getIsSendToEmail(Authentication authentication) {
        log.debug("Get is send to email request gotten");
        return userService.getSendToNotificationFlag(authenticationService.getUserId(authentication));
    }

    @PostMapping("/send-email")
    public void setSendToEmail (@RequestBody boolean flag, Authentication authentication) {
        log.debug("Set is send to email flag request gotten for value {}", flag);
        userService.setSendToNotificationFlag(authenticationService.getUserId(authentication), flag);
    }
}
