package ru.tsvlad.waydnotification.service;

import ru.tsvlad.waydnotification.commons.UserInfo;
import ru.tsvlad.waydnotification.messaging.dto.EmailCredentialsDTO;
import ru.tsvlad.waydnotification.messaging.dto.EventDTO;

import java.time.LocalDateTime;

public interface NotificationSenderService {
    void sendEventCreatedNotification(EventDTO eventDTO, UserInfo userInfo, LocalDateTime dateTime);
    void sendEventUpdatedNotification(EventDTO eventDTO, LocalDateTime dateTime);
    void sendOrganizationRegistered(EmailCredentialsDTO emailCredentialsDTO);
}
