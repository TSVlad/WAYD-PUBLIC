package ru.tsvlad.waydvalidator.service;

import org.springframework.security.core.Authentication;
import ru.tsvlad.waydvalidator.config.commons.UserInfo;

public interface AuthenticationService {
    String getUserId(Authentication authentication);
    UserInfo getUserInfo(Authentication authentication);
}
