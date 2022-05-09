package ru.tsvlad.wayd_moderation.service;

import org.springframework.security.core.Authentication;

public interface AuthenticationService {
    String getUserId(Authentication authentication);
}
