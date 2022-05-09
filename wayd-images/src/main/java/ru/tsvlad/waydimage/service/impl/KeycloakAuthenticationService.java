package ru.tsvlad.waydimage.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.stereotype.Service;
import ru.tsvlad.waydimage.commons.UserInfo;
import ru.tsvlad.waydimage.config.security.Role;
import ru.tsvlad.waydimage.service.AuthenticationService;

import java.time.LocalDate;
import java.util.stream.Collectors;

@Service
@Slf4j
public class KeycloakAuthenticationService implements AuthenticationService {
    @Override
    public String getUserId(Authentication authentication) {
        return authentication.getName();
    }

    @Override
    public UserInfo getUserInfo(Authentication authentication) {
        log.info("Check: {}", ((JwtAuthenticationToken) authentication).getTokenAttributes());
        Object dateOfBirth = ((JwtAuthenticationToken) authentication).getTokenAttributes().get("dateOfBirth");
        return UserInfo.builder()
                .id(authentication.getName())
                .dateOfBirth(dateOfBirth != null ? LocalDate.parse((String)dateOfBirth) : null)
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
