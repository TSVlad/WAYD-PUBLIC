package ru.tsvlad.waydorchestrator.consumer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import ru.tsvlad.waydorchestrator.messaging.EventMessage;
import ru.tsvlad.waydorchestrator.messaging.ImageMessage;
import ru.tsvlad.waydorchestrator.producer.ImageProducer;

@Component
@Slf4j
@AllArgsConstructor
public class ImageConsumer {

    private final ImageProducer imageProducer;

    @KafkaListener(topics = {"image-topic"}, containerFactory = "singleFactory")
    public void consume(ImageMessage message) {
        log.debug("Message from image service gotten: {}", message);
        switch (message.getType()) {
            case NEW_IMAGE:
                imageProducer.sendToNeuronValidator(message);
                break;
            case INVALID_IMAGE:
                imageProducer.sendToModeration(message);
                break;
        }
    }
}
