package ru.tsvlad.waydorchestrator.consumer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import ru.tsvlad.waydorchestrator.messaging.ValidatorMessage;
import ru.tsvlad.waydorchestrator.producer.ValidatorProducer;

@Component
@Slf4j
@AllArgsConstructor
public class ValidatorConsumer {
    private final ValidatorProducer validatorProducer;

    @KafkaListener(id = "orchestrator-event-validation-customer", topics = {"validator-topic"}, containerFactory = "singleFactory")
    public void consume(ValidatorMessage message) {
        log.debug("Message from validator service gotten: {}", message);
        switch (message.getType()) {
            case EVENT_VALIDATED:
                eventValidated(message);
                break;
            case USER_VALIDATED:
                userValidated(message);
                break;
        }

    }

    private void eventValidated(ValidatorMessage message) {
        validatorProducer.sendToEvent(message);
    }

    private void userValidated(ValidatorMessage message) {
        validatorProducer.sendToUser(message);
    }
}
