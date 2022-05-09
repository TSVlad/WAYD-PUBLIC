package com.example.waydevent.messaging.consumer.msg;

import com.example.waydevent.messaging.AbstractMessage;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ModerationMessage extends AbstractMessage {
    private ModerationMessageType type;
    private String objectId;
}
