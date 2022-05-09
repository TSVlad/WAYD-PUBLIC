package ru.tsvlad.waydnotification.service;

import org.springframework.security.core.Authentication;
import ru.tsvlad.waydnotification.commons.UserInfo;

public interface AuthenticationService {
    String getUserId(Authentication authentication);
    UserInfo getUserInfo(Authentication authentication);
}
