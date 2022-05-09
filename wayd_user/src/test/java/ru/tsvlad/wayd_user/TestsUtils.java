package ru.tsvlad.wayd_user;



import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import ru.tsvlad.wayd_user.commons.User;
import ru.tsvlad.wayd_user.enums.Role;
import ru.tsvlad.wayd_user.enums.UserAttribute;
import ru.tsvlad.wayd_user.enums.UserStatus;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static ru.tsvlad.wayd_user.enums.Role.*;

@Component
public class TestsUtils {
    @Autowired
    ObjectMapper objectMapper;

    public String toJson(Object obj) {
        try {
            return objectMapper.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    public <T> T toObject(String str, Class<T> type) throws IOException {
        return objectMapper.readValue(str, type);
    }

    public List<UserRepresentation> createUsersRepresentations(int n) {
        List<UserRepresentation> result = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            UserRepresentation userRepresentation = new UserRepresentation();
            userRepresentation.setId("id" + i);
            userRepresentation.setUsername("username" + i);
            userRepresentation.setFirstName("name" + i);
            userRepresentation.setLastName("surname" + i);
            userRepresentation.setEmail("email" + i);
            userRepresentation.singleAttribute(UserAttribute.dateOfBirth, LocalDate.of(1990, 1, 1)
                    .plus(i, ChronoUnit.DAYS).toString());
            userRepresentation.singleAttribute(UserAttribute.status, UserStatus.ACTIVE.name());
            userRepresentation.singleAttribute(UserAttribute.description, "description" + i);
            userRepresentation.singleAttribute(UserAttribute.contacts, "contacts" + i);
            userRepresentation.singleAttribute(UserAttribute.avatar, "avatar" + i);
            userRepresentation.setRealmRoles(getRolesByNumber(i + 1).stream()
                    .map(Enum::name).collect(Collectors.toList()));
            userRepresentation.setEnabled(true);
            result.add(userRepresentation);
        }
        return result;
    }

    public List<User> createUsers(int n) {
        List<User> result = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            result.add(User.builder()
                    .id("id" + i)
                    .surname("surname" + i)
                    .name("name" + i)
                    .contacts("contacts" + i)
                    .dateOfBirth(LocalDate.of(1990, 1, 1).plus(i, ChronoUnit.DAYS))
                    .username("username" + i)
                    .avatar("avatar" + i)
                    .description("description" + i)
                    .email("email" + i)
                    .roles(getRolesByNumber(i + 1))
                    .status(UserStatus.ACTIVE)
                    .build());
        }
        return result;
    }

    public List<Role> getRolesByNumber(int n) {
        if (n % 4 == 0) {
            return List.of(ROLE_USER, ROLE_PERSON, ROLE_MODERATOR, ROLE_ADMIN);
        } else if (n % 3 == 0) {
            return List.of(ROLE_USER, ROLE_PERSON, ROLE_MODERATOR);
        } else if (n % 2 == 0) {
            return List.of(ROLE_USER, ROLE_ORGANIZATION);
        } else {
            return List.of(ROLE_USER, ROLE_PERSON);
        }
    }
}
