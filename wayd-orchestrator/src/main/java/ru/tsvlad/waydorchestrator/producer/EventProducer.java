package ru.tsvlad.waydorchestrator.producer;

import lombok.AllArgsConstructor;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import ru.tsvlad.waydorchestrator.messaging.EventMessage;

@Service
@AllArgsConstructor
public class EventProducer {
    private final KafkaTemplate<Long, EventMessage> eventMessageKafkaTemplate;

    public void sendToValidator(EventMessage message) {
        eventMessageKafkaTemplate.send("event-to-validator", message);
    }

    public void sendToUser(EventMessage message) {
        eventMessageKafkaTemplate.send("event-to-user", message);
    }

    public void sendToNotification(EventMessage message) {
        eventMessageKafkaTemplate.send("event-to-notification", message);
    }
}
