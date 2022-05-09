package ru.tsvlad.wayd_moderation.restapi.dto;

import lombok.Data;
import ru.tsvlad.wayd_moderation.enums.ComplaintStatus;
import ru.tsvlad.wayd_moderation.enums.ComplaintType;

import java.time.ZonedDateTime;

@Data
public class ComplaintDTO {
    private String id;

    private ZonedDateTime created;
    private ZonedDateTime processed;

    private String topic;
    private String message;
    private String reason;

    private String complainingUserId;

    private String objectId;

    private ComplaintType type;

    private String moderatorId;
    private String moderatorComment;

    private ComplaintStatus complaintStatus;
}
