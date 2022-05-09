package ru.tsvlad.wayd_user.messaging.consumer.msg;

import lombok.Data;
import lombok.EqualsAndHashCode;
import ru.tsvlad.wayd_user.messaging.AbstractMessage;
import ru.tsvlad.wayd_user.messaging.consumer.msg.type.EventMessageType;
import ru.tsvlad.wayd_user.messaging.dto.EventDTO;


@EqualsAndHashCode(callSuper = true)
@Data
public class EventMessage extends AbstractMessage {
    private EventMessageType type;
    private EventDTO eventDTO;
    private long userId;

    public EventMessage() {
        super();
    }

    public EventMessage(EventMessageType type, EventDTO eventDTO) {
        super();
        this.type = type;
        this.eventDTO = eventDTO;
    }
}
