package ru.tsvlad.waydnotification.service.impl;

import org.springframework.stereotype.Service;
import ru.tsvlad.waydnotification.commons.UserInfo;
import ru.tsvlad.waydnotification.entity.NotificationEntity;
import ru.tsvlad.waydnotification.enums.NotificationStatus;
import ru.tsvlad.waydnotification.messaging.dto.EventDTO;
import ru.tsvlad.waydnotification.service.NotificationGeneratorService;

import java.time.ZonedDateTime;

@Service
public class NotificationGeneratorServiceImpl implements NotificationGeneratorService {

    @Override
    public NotificationEntity createNewEventFromSubscriptionNotification(EventDTO eventDTO, UserInfo userInfo, ZonedDateTime timestamp) {
        String body = String.format("User <a href=\"/user/%s\">%s</a> created new <a href=\"/event/%s\">event</a>", userInfo.getId(), userInfo.getUsername(), eventDTO.getId());
        return NotificationEntity.builder()
                .subject("New event")
                .status(NotificationStatus.NEW)
                .body(body)
                .timestamp(timestamp)
                .build();
    }

    @Override
    public NotificationEntity createUpdateEventNotification(EventDTO eventDTO, ZonedDateTime timestamp) {
        String body = String.format("<a href=\"/event/%s\">Event</a> you take participate in was updated", eventDTO.getId());
        return NotificationEntity.builder()
                .subject("Event was updated")
                .status(NotificationStatus.NEW)
                .body(body)
                .timestamp(timestamp)
                .build();
    }
}
