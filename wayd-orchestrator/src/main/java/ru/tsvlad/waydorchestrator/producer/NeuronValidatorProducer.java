package ru.tsvlad.waydorchestrator.producer;

import lombok.AllArgsConstructor;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import ru.tsvlad.waydorchestrator.messaging.NeuronValidatorMessage;

@Service
@AllArgsConstructor
public class NeuronValidatorProducer {
    private final KafkaTemplate<Long, NeuronValidatorMessage> neuronValidatorMessageKafkaTemplate;

    public void sendToImage(NeuronValidatorMessage message) {
        neuronValidatorMessageKafkaTemplate.send("neuron-validator-to-image", message);
    }
}
