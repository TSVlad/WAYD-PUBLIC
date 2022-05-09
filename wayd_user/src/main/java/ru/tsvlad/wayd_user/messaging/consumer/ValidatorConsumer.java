package ru.tsvlad.wayd_user.messaging.consumer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import ru.tsvlad.wayd_user.messaging.consumer.msg.ValidatorMessage;
import ru.tsvlad.wayd_user.service.UserService;

@Component
@AllArgsConstructor
@Slf4j
public class ValidatorConsumer {

    private UserService userService;

    @KafkaListener(topics = {"validator-to-user"}, containerFactory = "singleFactory")
    public void consume(ValidatorMessage validatorMessage) {
        log.debug("Message from validator service gotten: {}", validatorMessage);
        switch (validatorMessage.getType()) {
            case USER_VALIDATED:
                userValidated(validatorMessage);
                break;
        }
    }

    private void userValidated(ValidatorMessage validatorMessage) {
        userService.updateValidBadWords(validatorMessage.getUserId(), validatorMessage.getValidity());
    }
}
