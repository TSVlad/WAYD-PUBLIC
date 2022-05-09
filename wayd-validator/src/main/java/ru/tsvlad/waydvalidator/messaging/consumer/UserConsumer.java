package ru.tsvlad.waydvalidator.messaging.consumer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import ru.tsvlad.waydvalidator.messaging.consumer.msg.UserMessage;
import ru.tsvlad.waydvalidator.messaging.dto.UserKafkaDTO;
import ru.tsvlad.waydvalidator.messaging.producer.ValidatorServiceProducer;
import ru.tsvlad.waydvalidator.service.ValidationService;

@Component
@AllArgsConstructor
@Slf4j
public class UserConsumer {

    private ValidationService validationService;
    private ValidatorServiceProducer validatorServiceProducer;

    @KafkaListener(topics = {"user-to-validator"}, containerFactory = "singleFactory")
    public void consume(UserMessage userMessage) {
        log.debug("Message from user service gotten: {}", userMessage);
        switch (userMessage.getType()) {
            case CREATED:
            case UPDATED:
                validateUser(userMessage.getUserDTO());
                break;
        }
    }

    private void validateUser(UserKafkaDTO userKafkaDTO) {
        validatorServiceProducer.userValidated(userKafkaDTO.getId(), validationService.isValidUser(userKafkaDTO));
    }
}
