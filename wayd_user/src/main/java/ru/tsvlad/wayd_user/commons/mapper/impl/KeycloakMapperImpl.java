package ru.tsvlad.wayd_user.commons.mapper.impl;

import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.stereotype.Component;
import ru.tsvlad.wayd_user.commons.User;
import ru.tsvlad.wayd_user.commons.mapper.KeycloakMapper;
import ru.tsvlad.wayd_user.enums.Role;
import ru.tsvlad.wayd_user.enums.UserAttribute;
import ru.tsvlad.wayd_user.enums.UserStatus;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class KeycloakMapperImpl implements KeycloakMapper {
    @Override
    public User toUser(UserRepresentation userRepresentation) {
        Map<String, List<String>> attributes = userRepresentation.getAttributes();
        return User.builder()
                .id(userRepresentation.getId())
                .username(userRepresentation.getUsername())
                .email(userRepresentation.getEmail())
                .roles(userRepresentation.getRealmRoles() != null ?
                        userRepresentation.getRealmRoles().stream().map(Role::valueOf).collect(Collectors.toList())
                        : Collections.emptyList())
                .name(userRepresentation.getFirstName())
                .surname(userRepresentation.getLastName())
                .description(attributes.get(UserAttribute.description) != null && !attributes.get(UserAttribute.description).isEmpty()?
                        attributes.get(UserAttribute.description).get(0)
                        : null)
                .contacts(attributes.get(UserAttribute.contacts) != null && !attributes.get(UserAttribute.contacts).isEmpty()?
                        attributes.get(UserAttribute.contacts).get(0)
                        : null)
                .dateOfBirth(attributes.get(UserAttribute.dateOfBirth) != null? LocalDate.parse(attributes.get(UserAttribute.dateOfBirth).get(0)) : null)
                .status(UserStatus.valueOf(attributes.get(UserAttribute.status).get(0)))
                .avatar(attributes.get(UserAttribute.avatar) != null && !attributes.get(UserAttribute.avatar).isEmpty()?
                        attributes.get(UserAttribute.avatar).get(0)
                        : null)
                .build();
    }
}
