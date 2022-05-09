package ru.tsvlad.waydorchestrator.messaging;

import lombok.Data;
import lombok.EqualsAndHashCode;
import ru.tsvlad.waydorchestrator.messaging.dto.EventDTO;
import ru.tsvlad.waydorchestrator.messaging.type.EventMessageType;

@EqualsAndHashCode(callSuper = true)
@Data
public class EventMessage extends AbstractMessage {
    private EventMessageType type;
    private EventDTO eventDTO;
    private String userId;

    public EventMessage() {
        super();
    }

    public EventMessage(EventMessageType type, EventDTO eventDTO) {
        super();
        this.type = type;
        this.eventDTO = eventDTO;
    }
}
