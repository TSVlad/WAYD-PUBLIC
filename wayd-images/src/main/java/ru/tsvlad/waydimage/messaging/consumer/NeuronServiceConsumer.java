package ru.tsvlad.waydimage.messaging.consumer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import ru.tsvlad.waydimage.messaging.consumer.msg.NeuronValidatorMessage;
import ru.tsvlad.waydimage.service.ImageService;

@Component
@Slf4j
@AllArgsConstructor
public class NeuronServiceConsumer {

    private ImageService imageService;

    @KafkaListener(topics = {"neuron-validator-to-image"}, containerFactory = "singleFactory")
    public void consume(NeuronValidatorMessage message) {
        log.debug("Message gotten from neuron validation service {}", message);
        switch (message.getType()) {
            case IMAGE_VALIDATED:
                imageService.updateImageValidity(message.getImageId(), message.getValidity());
                break;
        }
    }
}
