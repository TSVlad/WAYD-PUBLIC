package ru.tsvlad.waydorchestrator.consumer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import ru.tsvlad.waydorchestrator.messaging.UserMessage;
import ru.tsvlad.waydorchestrator.producer.UserProducer;

@Component
@AllArgsConstructor
@Slf4j
public class UserConsumer {

    private UserProducer userProducer;

    @KafkaListener(topics = {"user-topic"}, containerFactory = "singleFactory")
    public void consume(UserMessage userMessage) {
        log.debug("Message from user service gotten: {}", userMessage);
        switch (userMessage.getType()) {
            case CREATED:
            case UPDATED:
                userProducer.sendToValidator(userMessage);
                break;
            case CONFIRMATION_CODE_GENERATED:
            case ORGANIZATION_REGISTERED:
                userProducer.sendToNotification(userMessage);
                break;
        }
    }
}
