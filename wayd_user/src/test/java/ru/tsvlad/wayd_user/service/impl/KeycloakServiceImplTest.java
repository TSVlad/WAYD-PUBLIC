package ru.tsvlad.wayd_user.service.impl;

import org.eclipse.sisu.plexus.Roles;
import org.junit.jupiter.api.Test;
import org.keycloak.admin.client.resource.*;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import ru.tsvlad.wayd_user.BaseIntegrationTest;
import ru.tsvlad.wayd_user.commons.OrganizationRegisterInfo;
import ru.tsvlad.wayd_user.commons.UserRegisterInfo;
import ru.tsvlad.wayd_user.commons.UserUpdateInfo;
import ru.tsvlad.wayd_user.enums.UserAttribute;
import ru.tsvlad.wayd_user.enums.UserStatus;

import javax.ws.rs.core.Response;
import java.net.URI;
import java.time.LocalDate;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@SpringBootTest
class KeycloakServiceImplTest extends BaseIntegrationTest {

    @Autowired
    KeycloakServiceImpl keycloakService;

    @MockBean
    RealmResource realmResource;
    @MockBean
    UsersResource usersResource;
    @MockBean
    UserResource userResource;
    @MockBean
    RoleMappingResource roleMappingResource;
    @MockBean
    RoleScopeResource roleScopeResource;
    @MockBean
    RolesResource rolesResource;
    @MockBean
    RoleResource roleResource;
    @MockBean
    RoleRepresentation roleRepresentation;

    @Test
    void addUserTest() {
        UserRegisterInfo userRegisterInfo = UserRegisterInfo.builder()
                .avatar("avatar0")
                .contacts("contacts0")
                .description("description0")
                .email("email0")
                .name("name0")
                .username("username0")
                .password("password0")
                .dateOfBirth(LocalDate.of(1990, 1, 1))
                .surname("surname0")
                .build();
        UserRepresentation userRepresentation = testsUtils.createUsersRepresentations(1).get(0);
        userRepresentation.setRealmRoles(List.of());
        userRepresentation.setId(null);
        userRepresentation.singleAttribute(UserAttribute.status, UserStatus.ON_VALIDATION.name());
        UserRepresentation expectedResult = testsUtils.createUsersRepresentations(1).get(0);
        userRepresentation.singleAttribute(UserAttribute.status, UserStatus.ON_VALIDATION.name());
        RoleRepresentation roleRepresentation = new RoleRepresentation();

        when(keycloakProperties.getRealm()).thenReturn("realm");
        when(keycloak.realm("realm")).thenReturn(realmResource);
        when(realmResource.users()).thenReturn(usersResource);
        when(usersResource.create(any())).thenReturn(Response.created(URI.create("id0")).build());
        when(usersResource.get("id0")).thenReturn(userResource);
        when(userResource.roles()).thenReturn(roleMappingResource);
        when(roleMappingResource.realmLevel()).thenReturn(roleScopeResource);
        when(realmResource.roles()).thenReturn(rolesResource);
        when(rolesResource.get(any())).thenReturn(roleResource);
        when(roleResource.toRepresentation()).thenReturn(roleRepresentation);
        when(userResource.toRepresentation()).thenReturn(expectedResult);
        when(roleScopeResource.listAll()).thenReturn(List.of(
                new RoleRepresentation("ROLE_USER", "", false),
                new RoleRepresentation("ROLE_PERSON", "", false)));

        UserRepresentation result = keycloakService.addUser(userRegisterInfo);

        verify(userResource).resetPassword(any());
        verify(userResource).sendVerifyEmail();
        assertEquals(expectedResult, result);
    }

    @Test
    void addOrganizationTest() {
        OrganizationRegisterInfo organizationRegisterInfo = OrganizationRegisterInfo.builder()
                .email("email")
                .username("username")
                .build();
        UserRepresentation userRepresentation = new UserRepresentation();
        userRepresentation.setUsername("username");
        userRepresentation.setEmail("email");
        userRepresentation.singleAttribute(UserAttribute.status, UserStatus.ACTIVE.name());
        userRepresentation.setEnabled(true);
        userRepresentation.setEmailVerified(true);

        UserRepresentation expectedResult = new UserRepresentation();
        expectedResult.setId("1");
        expectedResult.setUsername("username");
        expectedResult.setEmail("email");
        expectedResult.singleAttribute(UserAttribute.status, UserStatus.ACTIVE.name());
        expectedResult.setEnabled(true);
        expectedResult.setEmailVerified(true);

        when(keycloakProperties.getRealm()).thenReturn("realm");
        when(keycloak.realm("realm")).thenReturn(realmResource);
        when(realmResource.users()).thenReturn(usersResource);
        when(usersResource.create(any())).thenReturn(Response.created(URI.create("1")).build());
        when(usersResource.get("1")).thenReturn(userResource);
        when(userResource.roles()).thenReturn(roleMappingResource);
        when(roleMappingResource.realmLevel()).thenReturn(roleScopeResource);
        when(realmResource.roles()).thenReturn(rolesResource);
        when(rolesResource.get(any())).thenReturn(roleResource);
        when(roleResource.toRepresentation()).thenReturn(roleRepresentation);
        when(userResource.toRepresentation()).thenReturn(expectedResult);
        when(roleScopeResource.listAll()).thenReturn(List.of(
                new RoleRepresentation("ROLE_USER", "", false),
                new RoleRepresentation("ROLE_ORGANIZATION", "", false)));

        UserRepresentation result = keycloakService.addOrganization(organizationRegisterInfo);

        verify(userResource).executeActionsEmail(List.of("UPDATE_PASSWORD"));
        assertEquals(expectedResult, result);
    }

    @Test
    void updateUser() {
        UserUpdateInfo userUpdateInfo = UserUpdateInfo.builder()
                .id("id0")
                .name("new name")
                .surname("new surname")
                .description("new description")
                .contacts("new contacts")
                .avatar("new avatar")
                .build();
        UserRepresentation userRepresentation = testsUtils.createUsersRepresentations(1).get(0);

        UserRepresentation updatedRepresentation = testsUtils.createUsersRepresentations(1).get(0);
        updatedRepresentation.setFirstName("new name");
        updatedRepresentation.setLastName("new surname");
        updatedRepresentation.singleAttribute(UserAttribute.description, "new description");
        updatedRepresentation.singleAttribute(UserAttribute.contacts, "new contacts");
        updatedRepresentation.singleAttribute(UserAttribute.avatar, "new avatar");


        when(keycloakProperties.getRealm()).thenReturn("realm");
        when(keycloak.realm("realm")).thenReturn(realmResource);
        when(realmResource.users()).thenReturn(usersResource);
        when(usersResource.get("id0")).thenReturn(userResource);
        when(userResource.toRepresentation()).thenReturn(userRepresentation);
        when(userResource.roles()).thenReturn(roleMappingResource);
        when(roleMappingResource.realmLevel()).thenReturn(roleScopeResource);
        when(realmResource.roles()).thenReturn(rolesResource);
        when(rolesResource.get(any())).thenReturn(roleResource);
        when(roleResource.toRepresentation()).thenReturn(roleRepresentation);
        when(roleScopeResource.listAll()).thenReturn(List.of(
                new RoleRepresentation("ROLE_USER", "", false),
                new RoleRepresentation("ROLE_PERSON", "", false)));

        UserRepresentation result = keycloakService.updateUser(userUpdateInfo);

        verify(userResource).update(any());
        assertEquals(updatedRepresentation.getFirstName(), result.getFirstName());
        assertEquals(updatedRepresentation.getLastName(), result.getLastName());
        assertEquals(updatedRepresentation.getAttributes().get(UserAttribute.description),
                result.getAttributes().get(UserAttribute.description));
        assertEquals(updatedRepresentation.getAttributes().get(UserAttribute.avatar),
                result.getAttributes().get(UserAttribute.avatar));
        assertEquals(updatedRepresentation.getAttributes().get(UserAttribute.contacts),
                result.getAttributes().get(UserAttribute.contacts));
    }

    @Test
    void getUsersWithUsernameLike() {
        List<UserRepresentation> users = testsUtils.createUsersRepresentations(4);

        when(keycloakProperties.getRealm()).thenReturn("realm");
        when(keycloak.realm("realm")).thenReturn(realmResource);
        when(realmResource.users()).thenReturn(usersResource);
        when(usersResource.count()).thenReturn(20);
        when(usersResource.search("qwe", 8, 4)).thenReturn(users);
        when(usersResource.get(anyString())).thenReturn(userResource);
        when(userResource.roles()).thenReturn(roleMappingResource);
        when(roleMappingResource.realmLevel()).thenReturn(roleScopeResource);
        when(realmResource.roles()).thenReturn(rolesResource);
        when(rolesResource.get(any())).thenReturn(roleResource);
        when(roleResource.toRepresentation()).thenReturn(roleRepresentation);
        when(roleScopeResource.listAll()).thenReturn(
                List.of(
                        new RoleRepresentation("ROLE_USER", "", false),
                        new RoleRepresentation("ROLE_PERSON", "", false)),
                List.of(
                        new RoleRepresentation("ROLE_USER", "", false),
                        new RoleRepresentation("ROLE_ORGANIZATION", "", false)),
                List.of(
                        new RoleRepresentation("ROLE_USER", "", false),
                        new RoleRepresentation("ROLE_PERSON", "", false),
                        new RoleRepresentation("ROLE_MODERATOR", "", false)),
                List.of(
                        new RoleRepresentation("ROLE_USER", "", false),
                        new RoleRepresentation("ROLE_PERSON", "", false),
                        new RoleRepresentation("ROLE_MODERATOR", "", false),
                        new RoleRepresentation("ROLE_ADMIN", "", false)));

        PageImpl<UserRepresentation> expected = new PageImpl<>(users, PageRequest.of(2, 4), 20);
        Page<UserRepresentation> result = keycloakService.getUsersWithUsernameLike("qwe", 2, 4);
        assertEquals(4, result.getSize());
        assertEquals(2, result.getNumber());
    }

    @Test
    void getUserByIdTest() {
        UserRepresentation userRepresentation = testsUtils.createUsersRepresentations(1).get(0);
        when(keycloakProperties.getRealm()).thenReturn("realm");
        when(keycloak.realm("realm")).thenReturn(realmResource);
        when(realmResource.users()).thenReturn(usersResource);
        when(usersResource.get("1")).thenReturn(userResource);
        when(userResource.toRepresentation()).thenReturn(userRepresentation);
        when(userResource.roles()).thenReturn(roleMappingResource);
        when(roleMappingResource.realmLevel()).thenReturn(roleScopeResource);
        when(realmResource.roles()).thenReturn(rolesResource);
        when(rolesResource.get(any())).thenReturn(roleResource);
        when(roleResource.toRepresentation()).thenReturn(roleRepresentation);
        when(roleScopeResource.listAll()).thenReturn(List.of(
                new RoleRepresentation("ROLE_USER", "", false),
                new RoleRepresentation("ROLE_PERSON", "", false)));

        UserRepresentation result = keycloakService.getUserById("1");

        assertEquals(userRepresentation, result);
    }

    @Test
    void updateUserStatus() {
        UserRepresentation userRepresentation = testsUtils.createUsersRepresentations(1).get(0);
        when(keycloakProperties.getRealm()).thenReturn("realm");
        when(keycloak.realm("realm")).thenReturn(realmResource);
        when(realmResource.users()).thenReturn(usersResource);
        when(usersResource.get("1")).thenReturn(userResource);
        when(userResource.toRepresentation()).thenReturn(userRepresentation);

        keycloakService.updateUserStatus("1", UserStatus.ACTIVE);

        verify(userResource).update(any());
    }

    @Test
    void setUserEnabledTest() {
        UserRepresentation userRepresentation = testsUtils.createUsersRepresentations(1).get(0);
        when(keycloakProperties.getRealm()).thenReturn("realm");
        when(keycloak.realm("realm")).thenReturn(realmResource);
        when(realmResource.users()).thenReturn(usersResource);
        when(usersResource.get("1")).thenReturn(userResource);
        when(userResource.toRepresentation()).thenReturn(userRepresentation);

        keycloakService.setUserEnabled("1", false);
        verify(userResource).update(any());
        assertEquals(false, userRepresentation.isEnabled());
    }
}