package com.example.waydevent.messaging.producer;

import com.example.waydevent.business.UserInfo;
import com.example.waydevent.messaging.producer.msg.EventMessage;
import com.example.waydevent.messaging.type.EventMessageType;
import com.example.waydevent.restapi.dto.EventDTO;
import lombok.AllArgsConstructor;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@AllArgsConstructor
public class EventServiceProducer {
    private final KafkaTemplate<Long, EventMessage> kafkaStarshipTemplate;

    public void createEvent(EventDTO eventDTO, UserInfo userInfo) {
        send(EventMessage.builder()
                .type(EventMessageType.EVENT_CREATED)
                .eventDTO(eventDTO)
                .userInfo(userInfo)
                .build());
    }

    public void updateEvent(EventDTO eventDTO, UserInfo userInfo) {
        send(EventMessage.builder()
                .type(EventMessageType.EVENT_UPDATED)
                .eventDTO(eventDTO)
                .userInfo(userInfo)
                .build());
    }

    public void eventValidated(EventDTO eventDTO, UserInfo userInfo) {
        send(EventMessage.builder()
                .type(EventMessageType.EVENT_VALIDATED)
                .eventDTO(eventDTO)
                .created(LocalDateTime.now())
                .userInfo(userInfo)
                .build());
    }

    private void send(EventMessage dto) {
        kafkaStarshipTemplate.send("event-topic", dto);
    }
}
