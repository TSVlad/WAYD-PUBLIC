package ru.tsvlad.wayd_user.service;

import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.data.domain.Page;
import ru.tsvlad.wayd_user.commons.OrganizationRegisterInfo;
import ru.tsvlad.wayd_user.commons.UserRegisterInfo;
import ru.tsvlad.wayd_user.commons.UserUpdateInfo;
import ru.tsvlad.wayd_user.enums.UserStatus;

import java.util.List;

/**
 * Service for implementing requests to Keycloak.
 */
public interface KeycloakService {
    /**
     * Method for adding new user in keycloak database.
     *
     * @param userRegisterInfo Object with information for registration.
     * @return Keycloak user representation of added user.
     */
    UserRepresentation addUser(UserRegisterInfo userRegisterInfo);

    /**
     * Method for adding new organization in keycloak database.
     *
     * @param organizationRegisterInfo Object with information for registration.
     * @return Keycloak user representation of added organization.
     */
    UserRepresentation addOrganization(OrganizationRegisterInfo organizationRegisterInfo);

    /**
     * Method for updating user profile in keyclaok database.
     *
     * @param userUpdateInfo Object with updated user's fields.
     * @return Keycloak user representation of updated user.
     */
    UserRepresentation updateUser(UserUpdateInfo userUpdateInfo);

    /**
     * Method for getting page with users by text search
     *
     * @param username String for search
     * @param page Page number
     * @param size Page size
     * @return Page with Keycloak user representations of requested users
     */
    Page<UserRepresentation> getUsersWithUsernameLike(String username, int page, int size);

    /**
     * Method for getting users by ids.
     *
     * @param ids Users' ids
     * @return List of Keycloak user representations of requested users
     */
    List<UserRepresentation> getUsersByIds(List<String> ids);

    /**
     * Method for getting user by id.
     *
     * @param id User's id.
     * @return Keycloak user representations of requested user
     */
    UserRepresentation getUserById(String id);

    /**
     * Method for updating status of user.
     *
     * @param id Updated user's id.
     * @param status New status.
     */
    void updateUserStatus(String id, UserStatus status);

    /**
     * Method for (de)activating user in Keycloak.
     *
     * @param id (de)activated user's id.
     * @param isEnabled Should user be activated flag.
     */
    void setUserEnabled(String id, boolean isEnabled);
}
