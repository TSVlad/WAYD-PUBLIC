package ru.tsvlad.waydnotification.messaging.consumer.msg;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import ru.tsvlad.waydnotification.messaging.AbstractMessage;
import ru.tsvlad.waydnotification.messaging.consumer.msg.type.EventMessageType;
import ru.tsvlad.waydnotification.messaging.dto.EventDTO;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
public class EventMessage extends AbstractMessage {
    private EventMessageType type;
    private EventDTO eventDTO;
    private String userId;
}
