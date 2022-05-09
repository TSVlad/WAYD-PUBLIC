package ru.tsvlad.waydnotification.service.impl;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import ru.tsvlad.waydnotification.BaseIntegrationTest;
import ru.tsvlad.waydnotification.commons.UserInfo;
import ru.tsvlad.waydnotification.entity.NotificationEntity;
import ru.tsvlad.waydnotification.entity.UserEntity;
import ru.tsvlad.waydnotification.enums.NotificationStatus;
import ru.tsvlad.waydnotification.mail.EmailMessage;
import ru.tsvlad.waydnotification.mail.EmailService;
import ru.tsvlad.waydnotification.mail.EmailServiceImpl;
import ru.tsvlad.waydnotification.messaging.dto.EmailCredentialsDTO;
import ru.tsvlad.waydnotification.messaging.dto.EventDTO;
import ru.tsvlad.waydnotification.service.EmailGeneratorService;
import ru.tsvlad.waydnotification.service.NotificationGeneratorService;
import ru.tsvlad.waydnotification.service.NotificationService;
import ru.tsvlad.waydnotification.service.SubscriptionService;

import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.HashMap;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@SpringBootTest
class NotificationSenderServiceImplTest extends BaseIntegrationTest {

    @Autowired
    NotificationSenderServiceImpl notificationSenderService;

    @MockBean
    NotificationGeneratorService notificationGeneratorService;
    @MockBean
    EmailGeneratorService emailGeneratorService;
    @MockBean
    SubscriptionService subscriptionService;
    @MockBean
    EmailService emailService;
    @MockBean
    NotificationService notificationService;

    @Test
    void sendEventCreatedNotificationTest() {
        NotificationEntity notificationEntity = NotificationEntity.builder()
                .subject("subject")
                .status(NotificationStatus.NEW)
                .body("body")
                .build();
        EmailMessage emailMessage = EmailMessage.builder()
                .context(new HashMap<>())
                .subject("subject")
                .from("from")
                .templateLocation("location")
                .build();
        List<UserEntity> userEntities = List.of(
                UserEntity.builder()
                        .userId("1")
                        .email("email1")
                        .sendToEmail(true)
                        .build(),
                UserEntity.builder()
                        .userId("2")
                        .email("email2")
                        .build(),
                UserEntity.builder()
                        .userId("3")
                        .email("email3")
                        .sendToEmail(true)
                        .build()
        );
        NotificationEntity notificationEntity1 = NotificationEntity.builder()
                .subject("subject")
                .userId("1")
                .status(NotificationStatus.NEW)
                .body("body")
                .build();
        NotificationEntity notificationEntity2 = NotificationEntity.builder()
                .subject("subject")
                .userId("2")
                .status(NotificationStatus.NEW)
                .body("body")
                .build();
        NotificationEntity notificationEntity3 = NotificationEntity.builder()
                .subject("subject")
                .userId("3")
                .status(NotificationStatus.NEW)
                .body("body")
                .build();
        EmailMessage emailMessage1 = EmailMessage.builder()
                .context(new HashMap<>())
                .subject("subject")
                .to("email1")
                .from("from")
                .templateLocation("location")
                .build();
        EmailMessage emailMessage2 = EmailMessage.builder()
                .context(new HashMap<>())
                .subject("subject")
                .to("email2")
                .from("from")
                .templateLocation("location")
                .build();
        EmailMessage emailMessage3 = EmailMessage.builder()
                .context(new HashMap<>())
                .subject("subject")
                .to("email3")
                .from("from")
                .templateLocation("location")
                .build();

        when(notificationGeneratorService.createNewEventFromSubscriptionNotification(any(), any(), any()))
                .thenReturn(notificationEntity);
        when(emailGeneratorService.createNewEventCreatedEmailMessage(any(), any())).thenReturn(emailMessage);
        when(subscriptionService.getSubscribers("id")).thenReturn(userEntities);

        notificationSenderService.sendEventCreatedNotification(new EventDTO(), UserInfo.builder().id("id").build(), LocalDateTime.now());

        verify(notificationService, times(3)).saveNotification(any());
        verify(emailService, times(2)).send(any());
    }

    @Test
    void sendEventUpdatedNotificationTest() {
        EventDTO eventDTO = EventDTO.builder()
                .participantsIds(List.of("1", "2", "3"))
                .build();
        NotificationEntity notificationEntity = NotificationEntity.builder()
                .subject("subject")
                .status(NotificationStatus.NEW)
                .body("body")
                .build();
        EmailMessage emailMessage = EmailMessage.builder()
                .context(new HashMap<>())
                .subject("subject")
                .from("from")
                .templateLocation("location")
                .build();
        List<UserEntity> userEntities = List.of(
                UserEntity.builder()
                        .userId("1")
                        .email("email1")
                        .sendToEmail(true)
                        .build(),
                UserEntity.builder()
                        .userId("2")
                        .email("email2")
                        .build(),
                UserEntity.builder()
                        .userId("3")
                        .email("email3")
                        .sendToEmail(true)
                        .build()
        );

        when(notificationGeneratorService.createUpdateEventNotification(any(), any())).thenReturn(notificationEntity);
        when(emailGeneratorService.createEventUpdatedEmailMessage(eventDTO)).thenReturn(emailMessage);
        when(subscriptionService.getUsersByIds(List.of("1", "2", "3"))).thenReturn(userEntities);

        notificationSenderService.sendEventUpdatedNotification(eventDTO, LocalDateTime.now());

        verify(notificationService, times(3)).saveNotification(any());
        verify(emailService, times(2)).send(any());
    }

    @Test
    void sendOrganizationRegisteredTest() {
        EmailMessage emailMessage = EmailMessage.builder()
                .context(new HashMap<>())
                .subject("subject")
                .from("from")
                .templateLocation("location")
                .build();

        when(emailGeneratorService.createOrganizationRegisteredMessage(any())).thenReturn(emailMessage);

        notificationSenderService.sendOrganizationRegistered(new EmailCredentialsDTO());

        verify(emailService).send(emailMessage);
    }
}