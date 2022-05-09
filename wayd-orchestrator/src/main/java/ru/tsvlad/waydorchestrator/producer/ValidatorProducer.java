package ru.tsvlad.waydorchestrator.producer;

import lombok.AllArgsConstructor;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import ru.tsvlad.waydorchestrator.messaging.ValidatorMessage;

@Service
@AllArgsConstructor
public class ValidatorProducer {
    private final KafkaTemplate<Long, ValidatorMessage> validatorMessageKafkaTemplate;

    public void sendToEvent(ValidatorMessage message) {
        validatorMessageKafkaTemplate.send("validator-to-event", message);
    }

    public void sendToUser(ValidatorMessage message) {
        validatorMessageKafkaTemplate.send("validator-to-user", message);
    }
}
