package ru.tsvlad.wayd_user.commons.mapper;

import org.keycloak.representations.idm.UserRepresentation;
import ru.tsvlad.wayd_user.commons.User;

public interface KeycloakMapper {
    User toUser(UserRepresentation userRepresentation);
}
