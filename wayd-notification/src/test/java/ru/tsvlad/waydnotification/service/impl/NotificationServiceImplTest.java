package ru.tsvlad.waydnotification.service.impl;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import ru.tsvlad.waydnotification.BaseIntegrationTest;
import ru.tsvlad.waydnotification.commons.UserInfo;
import ru.tsvlad.waydnotification.entity.NotificationEntity;
import ru.tsvlad.waydnotification.enums.NotificationStatus;
import ru.tsvlad.waydnotification.repository.NotificationRepository;
import ru.tsvlad.waydnotification.restapi.controller.advice.exceptions.ConflictException;
import ru.tsvlad.waydnotification.restapi.controller.advice.exceptions.ForbiddenException;
import ru.tsvlad.waydnotification.restapi.controller.advice.exceptions.NotFoundException;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.when;

@SpringBootTest
class NotificationServiceImplTest extends BaseIntegrationTest {

    @Autowired
    NotificationServiceImpl notificationService;

    @MockBean
    NotificationRepository notificationRepository;

    @Test
    void saveNotificationTest() {
        NotificationEntity notificationEntity = NotificationEntity.builder()
                .body("body")
                .userId("1")
                .status(NotificationStatus.NEW)
                .timestamp(ZonedDateTime.now())
                .subject("subject")
                .build();

        when(notificationRepository.save(notificationEntity)).thenReturn(notificationEntity);

        NotificationEntity result = notificationService.saveNotification(notificationEntity);

        assertEquals(notificationEntity, result);
    }

    @Test
    void getNotificationsByStatusesTest() {
        List<NotificationEntity> notificationEntities = List.of(NotificationEntity.builder()
                        .body("body")
                        .userId("1")
                        .status(NotificationStatus.NEW)
                        .timestamp(ZonedDateTime.now())
                        .subject("subject")
                        .build(),
                NotificationEntity.builder()
                        .body("body")
                        .userId("1")
                        .status(NotificationStatus.NEW)
                        .timestamp(ZonedDateTime.now())
                        .subject("subject")
                        .build(),
                NotificationEntity.builder()
                        .body("body")
                        .userId("1")
                        .status(NotificationStatus.NEW)
                        .timestamp(ZonedDateTime.now())
                        .subject("subject")
                        .build());

        when(notificationRepository.findAllByUserIdAndStatusIn("1", List.of(NotificationStatus.NEW)))
                .thenReturn(notificationEntities);

        List<NotificationEntity> result = notificationService.getNotificationsByStatuses("1",
                List.of(NotificationStatus.NEW));

        assertEquals(notificationEntities, result);
    }

    @Test
    void getAllNotificationsTest() {
        List<NotificationEntity> notificationEntities = List.of(NotificationEntity.builder()
                        .body("body")
                        .userId("1")
                        .status(NotificationStatus.NEW)
                        .timestamp(ZonedDateTime.now())
                        .subject("subject")
                        .build(),
                NotificationEntity.builder()
                        .body("body")
                        .userId("1")
                        .status(NotificationStatus.NEW)
                        .timestamp(ZonedDateTime.now())
                        .subject("subject")
                        .build(),
                NotificationEntity.builder()
                        .body("body")
                        .userId("1")
                        .status(NotificationStatus.NEW)
                        .timestamp(ZonedDateTime.now())
                        .subject("subject")
                        .build());
        Page<NotificationEntity> page = new PageImpl<>(notificationEntities);

        when(notificationRepository.findAllNotificationsByUserId("1", PageRequest.of(0, 3)))
                .thenReturn(page);

        Page<NotificationEntity> result = notificationService.getAllNotifications("1", PageRequest.of(0, 3));

        assertEquals(page, result);
    }

    @Test
    void updateStatusTest() {
        ZonedDateTime zonedDateTime = ZonedDateTime.now();
        NotificationEntity notificationEntity = NotificationEntity.builder()
                .id(1)
                .body("body")
                .userId("1")
                .status(NotificationStatus.NEW)
                .timestamp(zonedDateTime)
                .subject("subject")
                .build();
        NotificationEntity notificationEntityAfter = NotificationEntity.builder()
                .id(1)
                .body("body")
                .userId("1")
                .status(NotificationStatus.READ)
                .timestamp(zonedDateTime)
                .subject("subject")
                .build();

        when(notificationRepository.findById(1L)).thenReturn(Optional.of(notificationEntity));
        when(notificationRepository.save(notificationEntityAfter)).thenReturn(notificationEntityAfter);

        NotificationEntity result = notificationService.updateStatus(1, NotificationStatus.READ,
                UserInfo.builder().id("1").build());

        assertEquals(notificationEntityAfter, result);
    }

    @Test
    void updateStatusNotFoundTest() {
        when(notificationRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(NotFoundException.class, () -> notificationService.updateStatus(1, NotificationStatus.READ,
                UserInfo.builder().id("1").build()));
    }

    @Test
    void updateStatusForbiddenTest() {
        ZonedDateTime zonedDateTime = ZonedDateTime.now();
        NotificationEntity notificationEntity = NotificationEntity.builder()
                .id(1)
                .body("body")
                .userId("2")
                .status(NotificationStatus.NEW)
                .timestamp(zonedDateTime)
                .subject("subject")
                .build();

        when(notificationRepository.findById(1L)).thenReturn(Optional.of(notificationEntity));

        assertThrows(ForbiddenException.class, () -> notificationService.updateStatus(1, NotificationStatus.READ,
                UserInfo.builder().id("1").build()));
    }

    @Test
    void updateStatusConflictTest() {
        ZonedDateTime zonedDateTime = ZonedDateTime.now();
        NotificationEntity notificationEntity = NotificationEntity.builder()
                .id(1)
                .body("body")
                .userId("1")
                .status(NotificationStatus.READ)
                .timestamp(zonedDateTime)
                .subject("subject")
                .build();

        when(notificationRepository.findById(1L)).thenReturn(Optional.of(notificationEntity));

        assertThrows(ConflictException.class, () -> notificationService.updateStatus(1, NotificationStatus.NEW,
                UserInfo.builder().id("1").build()));
    }
}