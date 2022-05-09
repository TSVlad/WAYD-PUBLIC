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
import ru.tsvlad.waydnotification.service.UserService;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@SpringBootTest
class SubscriptionServiceImplTest extends BaseIntegrationTest {

    @Autowired
    SubscriptionServiceImpl subscriptionService;

    @MockBean
    UserRepository userRepository;
    @MockBean
    UserService userService;

    @Test
    void subscribeTest() {
        UserEntity userEntitySubscriber = UserEntity.builder()
                .email("email1")
                .userId("1")
                .sendToEmail(false)
                .subscribers(List.of())
                .subscriptions(new ArrayList<>())
                .build();
        UserEntity userEntitySubscription = UserEntity.builder()
                .email("email2")
                .userId("2")
                .sendToEmail(false)
                .subscribers(List.of())
                .subscriptions(List.of())
                .build();
        UserEntity userEntityAfter = UserEntity.builder()
                .email("email1")
                .userId("1")
                .sendToEmail(false)
                .subscribers(List.of())
                .subscriptions(List.of(
                        UserEntity.builder()
                                .email("email2")
                                .userId("2")
                                .sendToEmail(false)
                                .subscribers(List.of())
                                .subscriptions(List.of())
                                .build()
                ))
                .build();

        when(userService.getUserById("1")).thenReturn(userEntitySubscriber);
        when(userService.getUserById("2")).thenReturn(userEntitySubscription);

        subscriptionService.subscribe("1", "2");

        verify(userRepository).save(userEntityAfter);
    }

    @Test
    void cancelSubscription() {
        UserEntity userEntitySubscription = UserEntity.builder()
                .email("email2")
                .userId("2")
                .sendToEmail(false)
                .subscribers(List.of())
                .subscriptions(List.of())
                .build();
        List<UserEntity> subscriptions = new ArrayList<>();
        subscriptions.add(userEntitySubscription);
        UserEntity userEntitySubscriber = UserEntity.builder()
                .email("email1")
                .userId("1")
                .sendToEmail(false)
                .subscribers(List.of())
                .subscriptions(subscriptions)
                .build();
        UserEntity userEntityAfter = UserEntity.builder()
                .email("email1")
                .userId("1")
                .sendToEmail(false)
                .subscribers(List.of())
                .subscriptions(new ArrayList<>())
                .build();

        when(userService.getUserById("1")).thenReturn(userEntitySubscriber);
        when(userService.getUserById("2")).thenReturn(userEntitySubscription);

        subscriptionService.cancelSubscription("1", "2");

        verify(userRepository).save(userEntityAfter);
    }

    @Test
    void getSubscriptionsTest() {
        List<UserEntity> userEntities = List.of(
                UserEntity.builder()
                        .email("email1")
                        .userId("1")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build(),
                UserEntity.builder()
                        .email("email2")
                        .userId("2")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build(),
                UserEntity.builder()
                        .email("email3")
                        .userId("3")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build()
        );
        UserEntity userEntity = UserEntity.builder()
                .email("email4")
                .userId("4")
                .sendToEmail(false)
                .subscribers(List.of())
                .subscriptions(userEntities)
                .build();

        when(userService.getUserById("4")).thenReturn(userEntity);

        List<UserEntity> result = subscriptionService.getSubscriptions("4");
        assertEquals(userEntities, result);
    }

    @Test
    void getSubscriptionsIdsTest() {
        List<UserEntity> userEntities = List.of(
                UserEntity.builder()
                        .email("email1")
                        .userId("1")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build(),
                UserEntity.builder()
                        .email("email2")
                        .userId("2")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build(),
                UserEntity.builder()
                        .email("email3")
                        .userId("3")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build()
        );
        List<String> subscriptionsIds = List.of("1", "2", "3");
        UserEntity userEntity = UserEntity.builder()
                .email("email4")
                .userId("4")
                .sendToEmail(false)
                .subscribers(List.of())
                .subscriptions(userEntities)
                .build();

        when(userService.getUserById("4")).thenReturn(userEntity);

        List<String> result = subscriptionService.getSubscriptionsIds("4");
        assertEquals(subscriptionsIds, result);
    }

    @Test
    void getUsersByIdsTest() {
        List<UserEntity> userEntities = List.of(
                UserEntity.builder()
                        .email("email1")
                        .userId("1")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build(),
                UserEntity.builder()
                        .email("email2")
                        .userId("2")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build(),
                UserEntity.builder()
                        .email("email3")
                        .userId("3")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build()
        );

        when(userRepository.findAllByUserIdIn(List.of("1", "2", "3"))).thenReturn(userEntities);

        List<UserEntity> result = subscriptionService.getUsersByIds(List.of("1", "2", "3"));

        assertEquals(userEntities, result);
    }

    @Test
    void getSubscribersTest() {
        List<UserEntity> userEntities = List.of(
                UserEntity.builder()
                        .email("email1")
                        .userId("1")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build(),
                UserEntity.builder()
                        .email("email2")
                        .userId("2")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build(),
                UserEntity.builder()
                        .email("email3")
                        .userId("3")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build()
        );
        UserEntity userEntity = UserEntity.builder()
                .email("email4")
                .userId("4")
                .sendToEmail(false)
                .subscribers(userEntities)
                .subscriptions(List.of())
                .build();

        when(userService.getUserById("4")).thenReturn(userEntity);

        List<UserEntity> result = subscriptionService.getSubscribers("4");
        assertEquals(userEntities, result);
    }

    @Test
    void getSubscribersIds() {
        List<UserEntity> userEntities = List.of(
                UserEntity.builder()
                        .email("email1")
                        .userId("1")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build(),
                UserEntity.builder()
                        .email("email2")
                        .userId("2")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build(),
                UserEntity.builder()
                        .email("email3")
                        .userId("3")
                        .sendToEmail(false)
                        .subscribers(List.of())
                        .subscriptions(List.of())
                        .build()
        );
        List<String> subscriptionsIds = List.of("1", "2", "3");
        UserEntity userEntity = UserEntity.builder()
                .email("email4")
                .userId("4")
                .sendToEmail(false)
                .subscribers(userEntities)
                .subscriptions(List.of())
                .build();

        when(userService.getUserById("4")).thenReturn(userEntity);

        List<String> result = subscriptionService.getSubscribersIds("4");
        assertEquals(subscriptionsIds, result);
    }
}