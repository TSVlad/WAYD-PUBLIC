package com.example.waydevent.messaging.consumer;

import com.example.waydevent.messaging.consumer.msg.ModerationMessage;
import com.example.waydevent.service.EventService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

@Component
@AllArgsConstructor
@Slf4j
public class ModeratorConsumer {
    private final EventService eventService;

    @KafkaListener(topics = {"moderation-to-event"}, containerFactory = "singleFactory")
    public void consume(ModerationMessage message) {
        log.debug("Message from moderation service: {}", message);
        switch (message.getType()) {
            case BLOCK_EVENT:
                eventService.blockDocument(message.getObjectId()).subscribe();
                break;
        }
    }
}
