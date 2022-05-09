package ru.tsvlad.waydimage.messaging.producer;

import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import ru.tsvlad.waydimage.document.ImageDocument;
import ru.tsvlad.waydimage.messaging.producer.msg.ImageMessage;
import ru.tsvlad.waydimage.messaging.producer.msg.ImageMessageType;
import ru.tsvlad.waydimage.restapi.dto.ImageDTO;

@Service
@AllArgsConstructor
public class ImageServiceProducer {
    private final KafkaTemplate<Long, ImageMessage> kafkaTemplate;
    private final ModelMapper modelMapper;

    public void newImage(byte[] image, ImageDocument imageDocument) {
        send(ImageMessage.builder()
                .type(ImageMessageType.NEW_IMAGE)
                .image(image)
                .imageDTO(modelMapper.map(imageDocument, ImageDTO.class))
                .build());
    }

    public void invalidImage(ImageDocument imageDocument) {
        send(ImageMessage.builder()
                .type(ImageMessageType.INVALID_IMAGE)
                .imageDTO(modelMapper.map(imageDocument, ImageDTO.class))
                .build());
    }

    private void send(ImageMessage message) {
        kafkaTemplate.send("image-topic", message);
    }
}
