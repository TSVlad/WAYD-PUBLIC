package ru.tsvlad.wayd_moderation.restapi.dto;

import lombok.Data;
import ru.tsvlad.wayd_moderation.enums.ComplaintType;

@Data
public class ComplaintPublicDTO {
    private String id;

    private String topic;
    private String message;
    private String reason;

    private String objectId;

    private ComplaintType type;
}
