package ru.tsvlad.waydnotification.messaging.consumer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import ru.tsvlad.waydnotification.messaging.consumer.msg.EventMessage;
import ru.tsvlad.waydnotification.service.NotificationSenderService;

@AllArgsConstructor
@Component
@Slf4j
public class EventConsumer {

    private final NotificationSenderService notificationSenderService;

    @KafkaListener(topics = {"event-to-notification"}, containerFactory = "singleFactory")
    public void consume(EventMessage eventMessage) {
        log.debug("Message fro event service gotten: {}", eventMessage);
        switch (eventMessage.getType()) {
            case EVENT_VALIDATED:
                eventValidated(eventMessage);
                break;
        }
    }

    private void eventValidated(EventMessage eventMessage) {
        if (eventMessage.getEventDTO().getVersion() == 2) {
            notificationSenderService.sendEventCreatedNotification(eventMessage.getEventDTO(), eventMessage.getUserInfo(), eventMessage.getCreated());
        } else {
            notificationSenderService.sendEventUpdatedNotification(eventMessage.getEventDTO(), eventMessage.getCreated());
        }
    }
}
