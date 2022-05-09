package ru.tsvlad.waydvalidator.service;

import ru.tsvlad.waydvalidator.messaging.dto.EventDTO;
import ru.tsvlad.waydvalidator.messaging.dto.UserKafkaDTO;
import ru.tsvlad.waydvalidator.messaging.producer.msg.Validity;

public interface ValidationService {
    Validity isValidEvent(EventDTO eventDTO);
    Validity isValidUser(UserKafkaDTO userKafkaDTO);
}
