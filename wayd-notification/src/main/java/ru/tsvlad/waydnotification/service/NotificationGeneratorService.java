package ru.tsvlad.waydnotification.service;

import ru.tsvlad.waydnotification.commons.UserInfo;
import ru.tsvlad.waydnotification.entity.NotificationEntity;
import ru.tsvlad.waydnotification.messaging.dto.EventDTO;

import java.time.ZonedDateTime;

public interface NotificationGeneratorService {
    NotificationEntity createNewEventFromSubscriptionNotification(EventDTO eventDTO, UserInfo userInfo, ZonedDateTime timestamp);
    NotificationEntity createUpdateEventNotification(EventDTO eventDTO, ZonedDateTime zonedDateTime);
}
