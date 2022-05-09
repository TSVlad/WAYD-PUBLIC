package ru.tsvlad.waydnotification.service.impl;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import ru.tsvlad.waydnotification.BaseIntegrationTest;
import ru.tsvlad.waydnotification.entity.UserEntity;
import ru.tsvlad.waydnotification.repository.UserRepository;

import java.util.List;
import java.util.Optional;

@SpringBootTest
class UserServiceImplTest extends BaseIntegrationTest {

    @Autowired
    UserServiceImpl userService;

    @MockBean
    UserRepository userRepository;

    @Test
    void getUserByIdTest() {
        UserEntity userEntity = UserEntity.builder()
                .email("email")
                .userId("1")
                .sendToEmail(true)
                .subscribers(List.of())
                .subscriptions(List.of())
                .build();

        Mockito.when(userRepository.findById("1")).thenReturn(Optional.of(userEntity));

        UserEntity result = userService.getUserById("1");

        Assertions.assertEquals(userEntity, result);
    }

    @Test
    void getSendToNotificationFlagTest() {
        UserEntity userEntity = UserEntity.builder()
                .email("email")
                .userId("1")
                .sendToEmail(true)
                .subscribers(List.of())
                .subscriptions(List.of())
                .build();

        Mockito.when(userRepository.findById("1")).thenReturn(Optional.of(userEntity));

        boolean result = userService.getSendToNotificationFlag("1");

        Assertions.assertTrue(result);
    }

    @Test
    void setSendToNotificationFlagTest() {
        UserEntity userEntity = UserEntity.builder()
                .email("email")
                .userId("1")
                .sendToEmail(true)
                .subscribers(List.of())
                .subscriptions(List.of())
                .build();
        UserEntity userEntityAfter = UserEntity.builder()
                .email("email")
                .userId("1")
                .sendToEmail(false)
                .subscribers(List.of())
                .subscriptions(List.of())
                .build();

        Mockito.when(userRepository.findById("1")).thenReturn(Optional.of(userEntity));

        userService.setSendToNotificationFlag("1", false);
        Mockito.verify(userRepository).save(userEntityAfter);
    }

    @Test
    void saveUserTest() {
        UserEntity userEntity = UserEntity.builder()
                .email("email")
                .userId("1")
                .sendToEmail(true)
                .subscribers(List.of())
                .subscriptions(List.of())
                .build();

        userService.saveUser("1", "email");
        Mockito.verify(userRepository).save(userEntity);
    }
}