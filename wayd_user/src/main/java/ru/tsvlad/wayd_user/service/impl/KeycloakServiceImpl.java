package ru.tsvlad.wayd_user.service.impl;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import ru.tsvlad.wayd_user.commons.OrganizationRegisterInfo;
import ru.tsvlad.wayd_user.commons.UserRegisterInfo;
import ru.tsvlad.wayd_user.commons.UserUpdateInfo;
import ru.tsvlad.wayd_user.config.props.KeycloakProperties;
import ru.tsvlad.wayd_user.enums.Role;
import ru.tsvlad.wayd_user.enums.UserAttribute;
import ru.tsvlad.wayd_user.enums.UserStatus;
import ru.tsvlad.wayd_user.restapi.controller.advise.exceptions.ConflictException;
import ru.tsvlad.wayd_user.restapi.controller.advise.exceptions.ServerException;
import ru.tsvlad.wayd_user.service.KeycloakService;

import javax.ws.rs.core.Response;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Slf4j
public class KeycloakServiceImpl implements KeycloakService {

    private final Keycloak keycloak;
    private final KeycloakProperties keycloakProperties;

    @Override
    public UserRepresentation addUser(UserRegisterInfo userRegisterInfo) {
        UserRepresentation userRepresentation = getUserRepresentation(userRegisterInfo);
        Response response = realm().users().create(userRepresentation);
        String id;
        if (response.getStatus() == HttpStatus.CREATED.value()) {
            id = getUserIdFromCreatedResponse(response);
        } else {
            id = resolveConflictAndAddUser(userRepresentation);
        }
        UserResource userResource = realm().users().get(id);
        userResource.resetPassword(createPasswordCredentials(userRegisterInfo.getPassword()));
        userResource.sendVerifyEmail();
        userResource.roles().realmLevel().add(getPersonRoles());

        UserRepresentation result = userResource.toRepresentation();
        //adding roles, because roles is always (?) null in representation
        result.setRealmRoles(getRealmRolesForUser(result.getId()));
        return result;
    }

    @Override
    public UserRepresentation addOrganization(OrganizationRegisterInfo organizationRegisterInfo) {
        UserRepresentation userRepresentation = getUserRepresentation(organizationRegisterInfo);
        Response response = realm().users().create(userRepresentation);
        if (response.getStatus() != HttpStatus.CREATED.value()) {
            log.error("Organization save failed. Keycloak status is {}", response.getStatus());
            throw new ServerException();
        }
        String id = getUserIdFromCreatedResponse(response);
        UserResource userResource = keycloak.realm(keycloakProperties.getRealm()).users().get(id);
        userResource.executeActionsEmail(List.of("UPDATE_PASSWORD"));
        List<RoleRepresentation> roles = getOrganizationRoles();
        userResource.roles().realmLevel().add(roles);

        UserRepresentation result = userResource.toRepresentation();
        //adding roles, because roles is always (?) null in representation
        result.setRealmRoles(getRealmRolesForUser(result.getId()));
        return result;
    }

    @Override
    public UserRepresentation updateUser(UserUpdateInfo userUpdateInfo) {
        UserResource userResource = realm().users().get(userUpdateInfo.getId());
        UserRepresentation updatedUser = updateUserFields(userResource.toRepresentation(), userUpdateInfo);
        userResource.update(updatedUser);
        updatedUser.setRealmRoles(getRealmRolesForUser(updatedUser.getId()));
        return updatedUser;
    }

    @Override
    public Page<UserRepresentation> getUsersWithUsernameLike(String username, int page, int size) {
        int count = realm().users().count(username);
        List<UserRepresentation> users = realm().users().search(username, page * size, size)
                .stream()
                .peek(userRepresentation -> {
                    userRepresentation.setRealmRoles(getRealmRolesForUser(userRepresentation.getId()));
                })
                .collect(Collectors.toList());
        return new PageImpl<>(users, PageRequest.of(page, size),
                count);
    }

    @Override
    public List<UserRepresentation> getUsersByIds(List<String> ids) {
        return ids.stream().map(this::getUserById).collect(Collectors.toList());
    }

    @Override
    public UserRepresentation getUserById(String id) {
        UserRepresentation userRepresentation = realm().users().get(id).toRepresentation();
        userRepresentation.setRealmRoles(getRealmRolesForUser(id));
        return userRepresentation;
    }

    @Override
    public void updateUserStatus(String id, UserStatus status) {
        UserResource userResource = realm().users().get(id);
        UserRepresentation userRepresentation = userResource.toRepresentation();
        userRepresentation.singleAttribute(UserAttribute.status, status.name());
        userResource.update(userRepresentation);
    }

    @Override
    public void setUserEnabled(String id, boolean isEnabled) {
        UserResource userResource = realm().users().get(id);
        UserRepresentation userRepresentation = userResource.toRepresentation();
        userRepresentation.setEnabled(isEnabled);
        userResource.update(userRepresentation);
    }

    private UserRepresentation updateUserFields(UserRepresentation userRepresentation, UserUpdateInfo userUpdateInfo) {
        userRepresentation.setFirstName(userUpdateInfo.getName());
        userRepresentation.setLastName(userUpdateInfo.getSurname());
        userRepresentation.singleAttribute(UserAttribute.description, userUpdateInfo.getDescription());
        userRepresentation.singleAttribute(UserAttribute.contacts, userUpdateInfo.getContacts());
        userRepresentation.singleAttribute(UserAttribute.status, UserStatus.ON_VALIDATION.name());
        userRepresentation.singleAttribute(UserAttribute.avatar, userUpdateInfo.getAvatar());
        return userRepresentation;
    }


    private String resolveConflictAndAddUser(UserRepresentation userRepresentation) {
        deleteUserWithSameUsernameIfNotVerified(userRepresentation.getUsername());
        deleteUserWithSameEmailIfNotVerified(userRepresentation.getEmail());
        Response response = keycloak.realm(keycloakProperties.getRealm()).users().create(userRepresentation);
        if (response.getStatus() != HttpStatus.CREATED.value()) {
            log.error("User wasn't created after conflict resolving. Got {} status in response from keycloak",
                    response.getStatus());
            throw new ServerException();
        }
        return getUserIdFromCreatedResponse(response);
    }

    private void deleteUserWithSameUsernameIfNotVerified(String username) {
        List<UserRepresentation> sameUsernameUsers = realm().users().search(username)
                        .stream()
                        .filter(userRepresentation -> userRepresentation.getUsername().equals(username))
                        .collect(Collectors.toList());
        if (!sameUsernameUsers.isEmpty()) {
            if (sameUsernameUsers.get(0).isEmailVerified()) {
                throw new ConflictException("Username " + username + " already exists");
            } else {
                keycloak.realm(keycloakProperties.getRealm()).users().delete(sameUsernameUsers.get(0).getId());
            }
        }
    }
    private void deleteUserWithSameEmailIfNotVerified(String email) {
        List<UserRepresentation> usersWithSameEmail = keycloak.realm(keycloakProperties.getRealm()).users()
                .search("", "", "", email, 0, 1)
                .stream()
                .filter(userRepresentation -> userRepresentation.getEmail().equals(email))
                .collect(Collectors.toList());;
        if (!usersWithSameEmail.isEmpty()) {
            if (usersWithSameEmail.get(0).isEmailVerified()) {
                throw new ConflictException("Email " + email + " already exists");
            } else {
                keycloak.realm(keycloakProperties.getRealm()).users().delete(usersWithSameEmail.get(0).getId());
            }
        }
    }

    private String getUserIdFromCreatedResponse(Response response) {
        if (response.getStatus() != 201) {
            throw new IllegalArgumentException("Impossible to get user's id: keycloak response status != 201!");
        }
        String[] location = response.getHeaderString("Location").split("/");
        return location[location.length - 1];
    }

    private UserRepresentation getUserRepresentation(UserRegisterInfo userRegisterInfo) {
        UserRepresentation userRepresentation = new UserRepresentation();
        userRepresentation.setUsername(userRegisterInfo.getUsername());
        userRepresentation.setFirstName(userRegisterInfo.getName());
        userRepresentation.setLastName(userRegisterInfo.getSurname());
        userRepresentation.setEmail(userRegisterInfo.getEmail());
        userRepresentation.singleAttribute(UserAttribute.dateOfBirth, userRegisterInfo.getDateOfBirth().toString());
        userRepresentation.singleAttribute(UserAttribute.status, UserStatus.ON_VALIDATION.name());
        userRepresentation.singleAttribute(UserAttribute.description, userRegisterInfo.getDescription());
        userRepresentation.singleAttribute(UserAttribute.contacts, userRegisterInfo.getContacts());
        userRepresentation.singleAttribute(UserAttribute.avatar, userRegisterInfo.getAvatar());
        userRepresentation.setEnabled(true);
        return userRepresentation;
    }

    private UserRepresentation getUserRepresentation(OrganizationRegisterInfo organizationRegisterInfo) {
        UserRepresentation userRepresentation = new UserRepresentation();
        userRepresentation.setUsername(organizationRegisterInfo.getUsername());
        userRepresentation.setEmail(organizationRegisterInfo.getEmail());
        userRepresentation.singleAttribute(UserAttribute.status, UserStatus.ACTIVE.name());
        userRepresentation.setEnabled(true);
        userRepresentation.setEmailVerified(true);
        return userRepresentation;
    }

    private CredentialRepresentation createPasswordCredentials(String password) {
        CredentialRepresentation credentialRepresentation = new CredentialRepresentation();
        credentialRepresentation.setTemporary(false);
        credentialRepresentation.setValue(password);
        credentialRepresentation.setType(CredentialRepresentation.PASSWORD);
        return credentialRepresentation;
    }

    private List<RoleRepresentation> getPersonRoles() {
        RealmResource realmRepresentation = keycloak.realm(keycloakProperties.getRealm());
        return List.of(realmRepresentation.roles().get(Role.ROLE_USER.name()).toRepresentation(),
                realmRepresentation.roles().get(Role.ROLE_PERSON.name()).toRepresentation());
    }

    private List<RoleRepresentation> getOrganizationRoles() {
        RealmResource realmRepresentation = keycloak.realm(keycloakProperties.getRealm());
        return List.of(realmRepresentation.roles().get(Role.ROLE_USER.name()).toRepresentation(),
                realmRepresentation.roles().get(Role.ROLE_ORGANIZATION.name()).toRepresentation());
    }

    private List<String> getRealmRolesForUser(String id) {
        return realm().users().get(id).roles().realmLevel().listAll()
                .stream()
                .map(RoleRepresentation::getName)
                .filter(str -> {
                    try {
                        Role.valueOf(str);
                        return true;
                    } catch (IllegalArgumentException e) {
                        return false;
                    }
                })
                .collect(Collectors.toList());
    }

    private RealmResource realm() {
        return keycloak.realm(keycloakProperties.getRealm());
    }
}
