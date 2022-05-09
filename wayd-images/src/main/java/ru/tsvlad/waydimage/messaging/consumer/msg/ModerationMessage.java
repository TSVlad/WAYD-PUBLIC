package ru.tsvlad.waydimage.messaging.consumer.msg;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.EqualsAndHashCode;
import ru.tsvlad.waydimage.messaging.AbstractMessage;
import ru.tsvlad.waydimage.messaging.consumer.msg.dto.ModeratorDecision;
import ru.tsvlad.waydimage.messaging.consumer.msg.type.ModerationMessageType;

@EqualsAndHashCode(callSuper = true)
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ModerationMessage extends AbstractMessage {
    private ModerationMessageType type;

    private String objectId;
    private ModeratorDecision decision;
}
