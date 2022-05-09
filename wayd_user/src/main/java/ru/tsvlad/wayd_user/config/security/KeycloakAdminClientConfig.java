package ru.tsvlad.wayd_user.config.security;

import lombok.RequiredArgsConstructor;
import org.keycloak.adapters.KeycloakConfigResolver;
import org.keycloak.adapters.KeycloakDeployment;
import org.keycloak.adapters.springboot.KeycloakSpringBootConfigResolver;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor
public class KeycloakAdminClientConfig {

    @Bean
    public Keycloak keycloak() {
        KeycloakDeployment keycloakDeployment = keycloakConfigResolver().resolve(null);


        return KeycloakBuilder.builder()
                .grantType("client_credentials")
                .serverUrl(keycloakDeployment.getAuthServerBaseUrl())
                .realm(keycloakDeployment.getRealm())
                .clientId(keycloakDeployment.getResourceName())
                .clientSecret((String)keycloakDeployment.getResourceCredentials().get("secret"))
                .build();
    }

    @Bean
    public KeycloakConfigResolver keycloakConfigResolver() {
        return new KeycloakSpringBootConfigResolver();
    }
}
