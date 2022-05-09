package com.example.waydevent.messaging.consumer;

import com.example.waydevent.messaging.consumer.msg.ValidatorMessage;
import com.example.waydevent.messaging.consumer.msg.ValidatorMessageType;
import com.example.waydevent.service.EventService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

@Component
@AllArgsConstructor
@Slf4j
public class ValidatorConsumer {
    private final EventService eventService;

    @KafkaListener(topics = {"validator-to-event"}, containerFactory = "singleFactory")
    public void consume(ValidatorMessage validatorMessage) {
        log.debug("Message from validator service: {}", validatorMessage);
        if (validatorMessage.getType() == ValidatorMessageType.EVENT_VALIDATED) {
            eventService.updateValidity(validatorMessage.getEventId(), validatorMessage.getValidity(), validatorMessage.getUserInfo());
        }
    }
}
