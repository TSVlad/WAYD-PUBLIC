package ru.tsvlad.wayd_moderation.messaging.producer;

import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import ru.tsvlad.wayd_moderation.document.BanDocument;
import ru.tsvlad.wayd_moderation.enums.ModeratorDecision;
import ru.tsvlad.wayd_moderation.messaging.producer.msg.ModerationMessage;
import ru.tsvlad.wayd_moderation.messaging.producer.msg.ModerationMessageType;
import ru.tsvlad.wayd_moderation.restapi.dto.BanDTO;

@Service
@AllArgsConstructor
public class ModerationServiceProducer {
    private final KafkaTemplate<Long, ModerationMessage> kafkaTemplate;

    private final ModelMapper modelMapper;

    public void banUser(BanDocument banDocument) {
        send(ModerationMessage.builder()
                .type(ModerationMessageType.BAN)
                .banDTO(modelMapper.map(banDocument, BanDTO.class))
                .build());
    }

    public void unbanUser(BanDocument banDocument) {
        send(ModerationMessage.builder()
                .type(ModerationMessageType.UNBAN)
                .banDTO(modelMapper.map(banDocument, BanDTO.class))
                .build());
    }


    public void blockEvent(String eventId) {
        send(ModerationMessage.builder()
                .type(ModerationMessageType.BLOCK_EVENT)
                .objectId(eventId)
                .build());
    }

    public void blockImage(String imageId) {
        send(ModerationMessage.builder()
                .type(ModerationMessageType.BLOCK_IMAGE)
                .objectId(imageId)
                .build());
    }

    private void send(ModerationMessage moderationMessage) {
        kafkaTemplate.send("moderation-topic", moderationMessage);
    }
}
