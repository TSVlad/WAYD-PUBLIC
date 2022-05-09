package ru.tsvlad.wayd_user.service.impl;

import org.junit.jupiter.api.Test;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import ru.tsvlad.wayd_user.BaseIntegrationTest;
import ru.tsvlad.wayd_user.commons.OrganizationRegisterInfo;
import ru.tsvlad.wayd_user.commons.User;
import ru.tsvlad.wayd_user.commons.UserRegisterInfo;
import ru.tsvlad.wayd_user.commons.UserUpdateInfo;
import ru.tsvlad.wayd_user.enums.UserAttribute;
import ru.tsvlad.wayd_user.enums.UserStatus;
import ru.tsvlad.wayd_user.enums.Validity;
import ru.tsvlad.wayd_user.service.KeycloakService;

import java.time.LocalDate;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;


@SpringBootTest
class UserServiceImplTest extends BaseIntegrationTest {

    @Autowired
    UserServiceImpl userService;

    @MockBean
    KeycloakService keycloakService;

    @Test
    void getAllActiveByUsernameTest() {
        when(keycloakService.getUsersWithUsernameLike("qwe", 1, 5))
                .thenReturn(new PageImpl<>(testsUtils.createUsersRepresentations(5)));
        Page<User> expectedResult = new PageImpl<>(testsUtils.createUsers(5));
        Page<User> result = userService.getAllActiveByUsername("qwe", 1, 5);
        assertEquals(expectedResult, result);
    }

    @Test
    void getAllByIdsTest() {
        when(keycloakService.getUsersByIds(List.of("1", "2", "3"))).thenReturn(testsUtils.createUsersRepresentations(3));
        List<User> expectedResult = testsUtils.createUsers(3);
        List<User> result = userService.getAllByIds(List.of("1", "2", "3"));
        assertEquals(expectedResult, result);
    }

    @Test
    void getUserByIdTest() {
        when(keycloakService.getUserById("1")).thenReturn(testsUtils.createUsersRepresentations(1).get(0));
        User expectedResult = testsUtils.createUsers(1).get(0);
        User result = userService.getUserById("1");
        assertEquals(expectedResult, result);
    }

    @Test
    void registerUserTest() {
        UserRegisterInfo userRegisterInfo = UserRegisterInfo.builder()
                .avatar("avatar")
                .contacts("contacts")
                .description("description")
                .email("email")
                .name("name")
                .username("username")
                .password("password")
                .dateOfBirth(LocalDate.of(1990, 4, 6))
                .surname("surname")
                .build();
        when(keycloakService.addUser(userRegisterInfo)).thenReturn(testsUtils.createUsersRepresentations(1).get(0));
        User expectedResult = testsUtils.createUsers(1).get(0);
        User result = userService.registerUser(userRegisterInfo);
        assertEquals(expectedResult, result);
    }

    @Test
    void registerOrganizationTest() {
        OrganizationRegisterInfo organizationRegisterInfo = OrganizationRegisterInfo.builder()
                .username("username")
                .email("email")
                .build();
        when(keycloakService.addOrganization(organizationRegisterInfo)).thenReturn(testsUtils.createUsersRepresentations(2).get(1));
        User expectedResult = testsUtils.createUsers(2).get(1);
        User result = userService.registerOrganization(organizationRegisterInfo);
        assertEquals(expectedResult, result);
    }

    @Test
    void updateUserTest() {
        UserUpdateInfo userUpdateInfo = UserUpdateInfo.builder()
                .avatar("avatar")
                .id("id")
                .name("name")
                .contacts("contacts")
                .description("description")
                .surname("surname")
                .build();
        when(keycloakService.updateUser(userUpdateInfo)).thenReturn(testsUtils.createUsersRepresentations(1).get(0));
        User expectedResult = testsUtils.createUsers(1).get(0);
        User result = userService.updateUser(userUpdateInfo);
        assertEquals(expectedResult, result);
    }

    @Test
    void updateValidBadWordsToValidTest() {
        UserRepresentation userRepresentation = testsUtils.createUsersRepresentations(1).get(0);
        userRepresentation.singleAttribute(UserAttribute.status, UserStatus.ON_VALIDATION.name());
        when(keycloakService.getUserById("id")).thenReturn(userRepresentation);
        userService.updateValidBadWords("id", Validity.VALID);
        verify(keycloakService).updateUserStatus("id", UserStatus.ACTIVE);
    }

    @Test
    void updateValidBadWordsToInvalidTest() {
        UserRepresentation userRepresentation = testsUtils.createUsersRepresentations(1).get(0);
        userRepresentation.singleAttribute(UserAttribute.status, UserStatus.ON_VALIDATION.name());
        when(keycloakService.getUserById("id")).thenReturn(userRepresentation);
        userService.updateValidBadWords("id", Validity.NOT_VALID);
        verify(keycloakService).updateUserStatus("id", UserStatus.INVALID_BAD_WORDS);
    }

    @Test
    void updateValidBadWordsToValidWithoutValidationTest() {
        UserRepresentation userRepresentation = testsUtils.createUsersRepresentations(1).get(0);
        when(keycloakService.getUserById("id")).thenReturn(userRepresentation);
        userService.updateValidBadWords("id", Validity.VALID);
        verify(keycloakService, times(0)).updateUserStatus("id", UserStatus.ACTIVE);
    }

    @Test
    void updateValidBadWordsToInvalidWithoutValidationTest() {
        UserRepresentation userRepresentation = testsUtils.createUsersRepresentations(1).get(0);
        when(keycloakService.getUserById("id")).thenReturn(userRepresentation);
        userService.updateValidBadWords("id", Validity.NOT_VALID);
        verify(keycloakService, times(0)).updateUserStatus("id", UserStatus.INVALID_BAD_WORDS);
    }

    @Test
    void banUserTest() {
        userService.banUser("id");
        verify(keycloakService).setUserEnabled("id", false);
    }

    @Test
    void unbanUserTest() {
        userService.unbanUser("id");
        verify(keycloakService).setUserEnabled("id", true);
    }


}