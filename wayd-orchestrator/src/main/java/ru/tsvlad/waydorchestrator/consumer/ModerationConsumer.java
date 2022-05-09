package ru.tsvlad.waydorchestrator.consumer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import ru.tsvlad.waydorchestrator.messaging.ModerationMessage;
import ru.tsvlad.waydorchestrator.producer.ModerationProducer;

@Component
@Slf4j
@AllArgsConstructor
public class ModerationConsumer {

    private final ModerationProducer moderationProducer;

    @KafkaListener(topics = {"moderation-topic"}, containerFactory = "singleFactory")
    public void consume(ModerationMessage message) {
        log.debug("Message from moderation service gotten: {}", message);
        switch (message.getType()) {
            case BAN:
                ban(message);
                break;
            case UNBAN:
                unban(message);
                break;
            case BLOCK_EVENT:
                moderationProducer.sendToEvent(message);
                break;
            case BLOCK_IMAGE:
                moderationProducer.sendToImage(message);
                break;
        }

    }

    private void ban(ModerationMessage message) {
        moderationProducer.sendToUser(message);
    }

    private void unban(ModerationMessage message) {
        moderationProducer.sendToUser(message);
    }
}
