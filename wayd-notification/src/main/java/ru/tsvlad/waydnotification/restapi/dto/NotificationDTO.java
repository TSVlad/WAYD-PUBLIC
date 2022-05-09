package ru.tsvlad.waydnotification.restapi.dto;

import lombok.Data;
import ru.tsvlad.waydnotification.enums.NotificationStatus;

import java.time.ZonedDateTime;

@Data
public class NotificationDTO {
    private long id;

    private String userId;

    private String subject;
    private String body;
    private ZonedDateTime timestamp;

    private NotificationStatus status;
}
