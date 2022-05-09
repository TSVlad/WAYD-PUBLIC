package ru.tsvlad.waydvalidator.messaging.producer;

import lombok.AllArgsConstructor;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import ru.tsvlad.waydvalidator.config.commons.UserInfo;
import ru.tsvlad.waydvalidator.messaging.producer.msg.ValidatorMessage;
import ru.tsvlad.waydvalidator.messaging.producer.msg.ValidatorMessageType;
import ru.tsvlad.waydvalidator.messaging.producer.msg.Validity;

@Service
@AllArgsConstructor
public class ValidatorServiceProducer {
    private final KafkaTemplate<Long, ValidatorMessage> validatorMessageKafkaTemplate;

    public void eventValidation(String id, Validity validity, UserInfo userInfo) {
        send(ValidatorMessage.builder()
                .type(ValidatorMessageType.EVENT_VALIDATED)
                .eventId(id)
                .validity(validity)
                .userInfo(userInfo)
                .build());
    }

    public void userValidated(String id, Validity validity) {
        send(ValidatorMessage.builder()
                .type(ValidatorMessageType.USER_VALIDATED)
                .userId(id)
                .validity(validity)
                .build());
    }

    private void send(ValidatorMessage message) {
        validatorMessageKafkaTemplate.send("validator-topic", message);
    }
}
