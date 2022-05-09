package ru.tsvlad.waydorchestrator.producer;

import lombok.AllArgsConstructor;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import ru.tsvlad.waydorchestrator.messaging.UserMessage;

@Service
@AllArgsConstructor
public class UserProducer {

    private KafkaTemplate<Long, UserMessage> userMessageKafkaTemplate;

    public void sendToValidator(UserMessage message) {
        userMessageKafkaTemplate.send("user-to-validator", message);
    }

    public void sendToNotification(UserMessage message) {
        userMessageKafkaTemplate.send("user-to-notification", message);
    }
}
