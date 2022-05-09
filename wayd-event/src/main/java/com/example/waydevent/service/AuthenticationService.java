package com.example.waydevent.service;

import com.example.waydevent.business.UserInfo;
import org.springframework.security.core.Authentication;

public interface AuthenticationService {
    String getUserId(Authentication authentication);
    UserInfo getUserInfo(Authentication authentication);
}
