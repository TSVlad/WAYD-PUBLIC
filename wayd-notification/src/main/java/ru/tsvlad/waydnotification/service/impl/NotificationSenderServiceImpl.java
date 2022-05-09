package ru.tsvlad.waydnotification.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.tsvlad.waydnotification.commons.UserInfo;
import ru.tsvlad.waydnotification.entity.NotificationEntity;
import ru.tsvlad.waydnotification.entity.UserEntity;
import ru.tsvlad.waydnotification.mail.EmailMessage;
import ru.tsvlad.waydnotification.mail.EmailService;
import ru.tsvlad.waydnotification.messaging.dto.EmailCredentialsDTO;
import ru.tsvlad.waydnotification.messaging.dto.EventDTO;
import ru.tsvlad.waydnotification.service.*;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class NotificationSenderServiceImpl implements NotificationSenderService {

    @Value("${spring.mail.username}")
    private String addressFrom;

    private final EmailService emailService;
    private final EmailGeneratorService emailGeneratorService;
    private final NotificationService notificationService;
    private final NotificationGeneratorService notificationGeneratorService;
    private final SubscriptionService subscriptionService;

    @Override
    @Transactional
    public void sendEventCreatedNotification(EventDTO eventDTO, UserInfo userInfo, LocalDateTime dateTime) {
        NotificationEntity notification = notificationGeneratorService
                .createNewEventFromSubscriptionNotification(eventDTO, userInfo, dateTime.atZone(ZoneId.systemDefault()));
        EmailMessage emailMessage = emailGeneratorService.createNewEventCreatedEmailMessage(eventDTO, userInfo);
        sendToSubscribers(userInfo.getId(), notification, emailMessage);
    }

    private void sendToSubscribers(String userId, NotificationEntity notification, EmailMessage emailMessage) {
        List<UserEntity> subscribers = subscriptionService.getSubscribers(userId);
        sendTo(subscribers, notification, emailMessage);
    }

    @Override
    public void sendEventUpdatedNotification(EventDTO eventDTO, LocalDateTime dateTime) {
        NotificationEntity notification = notificationGeneratorService.createUpdateEventNotification(eventDTO, dateTime.atZone(ZoneId.systemDefault()));
        EmailMessage emailMessage = emailGeneratorService.createEventUpdatedEmailMessage(eventDTO);
        sendToParticipants(eventDTO.getParticipantsIds(), notification, emailMessage);
    }

    @Override
    public void sendOrganizationRegistered(EmailCredentialsDTO emailCredentialsDTO) {
        emailService.send(emailGeneratorService.createOrganizationRegisteredMessage(emailCredentialsDTO));
    }

    private void sendToParticipants(List<String> participantsIds, NotificationEntity notification, EmailMessage emailMessage) {
        List<UserEntity> participants = subscriptionService.getUsersByIds(participantsIds);
        sendTo(participants, notification, emailMessage);
    }

    private void sendTo(List<UserEntity> users, NotificationEntity notification, EmailMessage emailMessage) {
        for (UserEntity user : users) {
            if (notification != null) {
                notification.setUserId(user.getUserId());
                notificationService.saveNotification(notification);
            }
            if (emailMessage != null && user.isSendToEmail()) {
                emailMessage.setTo(user.getEmail());
                emailService.send(emailMessage);
            }
        }
    }
}
