package ru.tsvlad.waydnotification.messaging.consumer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import ru.tsvlad.waydnotification.messaging.consumer.msg.UserMessage;
import ru.tsvlad.waydnotification.service.NotificationSenderService;
import ru.tsvlad.waydnotification.service.UserService;

@Component
@AllArgsConstructor
@Slf4j
public class UserConsumer {

    private final NotificationSenderService notificationSenderService;
    private final UserService userService;

    @KafkaListener(topics = {"user-to-notification"}, containerFactory = "singleFactory")
    public void consume(UserMessage userMessage) {
        log.debug("Message from user service gotten: {}", userMessage);
        switch (userMessage.getType()) {
            case CREATED:
                userService.saveUser(userMessage.getUserDTO().getId(),
                        userMessage.getUserDTO().getEmail());
                break;
            case ORGANIZATION_REGISTERED:
                userService.saveUser(userMessage.getEmailCredentialsDTO().getUserId(),
                        userMessage.getEmailCredentialsDTO().getEmail());
                notificationSenderService.sendOrganizationRegistered(userMessage.getEmailCredentialsDTO());
                break;
        }
    }
}
