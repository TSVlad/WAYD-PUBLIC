package ru.tsvlad.waydorchestrator.consumer;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import ru.tsvlad.waydorchestrator.messaging.ImageMessage;
import ru.tsvlad.waydorchestrator.messaging.NeuronValidatorMessage;
import ru.tsvlad.waydorchestrator.producer.NeuronValidatorProducer;

@Component
@Slf4j
@AllArgsConstructor
public class NeuronValidatorConsumer {

    private final NeuronValidatorProducer neuronValidatorProducer;

    @KafkaListener(topics = {"neuron-validator-topic"}, containerFactory = "singleFactory")
    public void consume(NeuronValidatorMessage message) {
        log.debug("Message from neuron service gotten: {}", message);
        switch (message.getType()) {
            case IMAGE_VALIDATED:
                neuronValidatorProducer.sendToImage(message);
        }
    }
}
