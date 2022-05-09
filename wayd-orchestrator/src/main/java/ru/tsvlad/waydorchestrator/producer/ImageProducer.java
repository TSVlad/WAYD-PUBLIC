package ru.tsvlad.waydorchestrator.producer;

import lombok.AllArgsConstructor;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import ru.tsvlad.waydorchestrator.messaging.ImageMessage;

@Service
@AllArgsConstructor
public class ImageProducer {
    private final KafkaTemplate<Long, ImageMessage> imageMessageKafkaTemplate;

    public void sendToNeuronValidator(ImageMessage message) {
        imageMessageKafkaTemplate.send("image-to-neuron-validator", message);
    }

    public void sendToModeration(ImageMessage message) {
        imageMessageKafkaTemplate.send("image-to-moderation", message);
    }
}
