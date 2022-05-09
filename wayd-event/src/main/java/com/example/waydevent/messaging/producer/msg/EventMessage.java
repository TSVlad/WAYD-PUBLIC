package com.example.waydevent.messaging.producer.msg;

import com.example.waydevent.messaging.AbstractMessage;
import com.example.waydevent.messaging.type.EventMessageType;
import com.example.waydevent.restapi.dto.EventDTO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.SuperBuilder;

@EqualsAndHashCode(callSuper = true)
@Data
@SuperBuilder
public class EventMessage extends AbstractMessage {
    private EventMessageType type;
    private EventDTO eventDTO;
    private String userId;
}
