package com.example.waydevent.service.impl;

import com.example.waydevent.business.UserInfo;
import com.example.waydevent.config.security.Role;
import com.example.waydevent.service.AuthenticationService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.stream.Collectors;

@Service
public class KeycloakAuthenticationService implements AuthenticationService {
    @Override
    public String getUserId(Authentication authentication) {
        return authentication.getName();
    }

    @Override
    public UserInfo getUserInfo(Authentication authentication) {
        return UserInfo.builder()
                .id(authentication.getName())
                .dateOfBirth(LocalDate.parse((String)((JwtAuthenticationToken)authentication).getTokenAttributes().get("dateOfBirth")))
                .roles(authentication.getAuthorities().stream().filter(role -> {
                    try {
                        Role.valueOf(role.getAuthority());
                        return true;
                    } catch (Exception e) {
                        return false;
                    }}).map(role -> Role.valueOf(role.getAuthority())).collect(Collectors.toList())
                )
                .build();
    }
}
