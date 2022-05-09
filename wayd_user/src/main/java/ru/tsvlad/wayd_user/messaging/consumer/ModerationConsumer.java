package ru.tsvlad.wayd_user.messaging.consumer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import ru.tsvlad.wayd_user.messaging.consumer.msg.ModerationMessage;
import ru.tsvlad.wayd_user.service.UserService;

@Component
@AllArgsConstructor
@Slf4j
public class ModerationConsumer {

    private final UserService userService;

    @KafkaListener(topics = {"moderation-to-user"}, containerFactory = "singleFactory")
    public void consume(ModerationMessage message) {
        log.debug("Message from moderation service gotten: {}", message);
        switch (message.getType()) {
            case BAN:
                ban(message);
                break;
            case UNBAN:
                unban(message);
                break;
        }
    }

    private void ban(ModerationMessage message) {
        userService.banUser(message.getBanDTO().getUserId());
    }

    private void unban(ModerationMessage message) {
        userService.unbanUser(message.getBanDTO().getUserId());
    }
}
