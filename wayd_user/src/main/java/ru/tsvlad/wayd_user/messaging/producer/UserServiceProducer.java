package ru.tsvlad.wayd_user.messaging.producer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import ru.tsvlad.wayd_user.messaging.dto.UserKafkaDTO;
import ru.tsvlad.wayd_user.messaging.producer.msg.UserMessage;
import ru.tsvlad.wayd_user.messaging.producer.msg.UserMessageType;

/**
 * Kafka messages producer.
 */
@Service
@AllArgsConstructor
@Slf4j
public class UserServiceProducer {
    private final KafkaTemplate<Long, UserMessage> userMessageKafkaTemplate;

    /**
     * Sending message about new user.
     *
     * @param userDTO dto with user.
     */
    public void registerAccount(UserKafkaDTO userDTO) {
        send(UserMessage.builder()
                .type(UserMessageType.CREATED)
                .userDTO(userDTO)
                .build());
    }

    /**
     * Sending message about user update.
     *
     * @param userPublicDTO dto with user.
     */
    public void updateAccount(UserKafkaDTO userPublicDTO) {
        send(UserMessage.builder()
                .type(UserMessageType.UPDATED)
                .userDTO(userPublicDTO)
                .build());
    }

    private void send(UserMessage message) {
        userMessageKafkaTemplate.send("user-topic", message);
    }
}
