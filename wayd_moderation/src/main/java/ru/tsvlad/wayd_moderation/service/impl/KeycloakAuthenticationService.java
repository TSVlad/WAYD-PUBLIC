package ru.tsvlad.wayd_moderation.service.impl;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import ru.tsvlad.wayd_moderation.service.AuthenticationService;

@Service
public class KeycloakAuthenticationService implements AuthenticationService {
    @Override
    public String getUserId(Authentication authentication) {
        return authentication.getName();
    }
}
