package ru.tsvlad.waydimage.service;

import org.springframework.security.core.Authentication;
import ru.tsvlad.waydimage.commons.UserInfo;

public interface AuthenticationService {
    String getUserId(Authentication authentication);
    UserInfo getUserInfo(Authentication authentication);
}
