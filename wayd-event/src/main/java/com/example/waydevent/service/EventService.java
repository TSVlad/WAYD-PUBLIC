package com.example.waydevent.service;

import com.example.waydevent.business.RateEvent;
import com.example.waydevent.business.UserInfo;
import com.example.waydevent.document.EventDocument;
import com.example.waydevent.messaging.consumer.dto.Validity;
import com.example.waydevent.restapi.dto.EventDTO;
import com.example.waydevent.restapi.dto.EventFilterDTO;
import com.example.waydevent.restapi.dto.EventForCreateAndUpdateDTO;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDate;
import java.util.List;

public interface EventService {
    Mono<EventDTO> saveEvent(EventForCreateAndUpdateDTO eventForCreateAndUpdateDTO, UserInfo userInfo);

    Flux<EventDTO> getEventsInPolygonForFilters(EventFilterDTO eventFilterDTO, LocalDate finderDateOfBirth);

    Flux<EventDTO> getEventsForUserId(String id);

    Flux<EventDocument> getEventsForParticipantId(String id);

    Flux<EventDTO> getEventsForIds(List<String> ids);

    Mono<EventDocument> getEventById(String id);

    Mono<EventDTO> addParticipant(String eventId, UserInfo userInfo);

    Mono<EventDocument> cancelParticipation(String eventId, UserInfo userInfo);

    void updateValidity(String id, Validity validity, UserInfo userInfo);

    Mono<EventDocument> rateEvent(RateEvent rateEvent, String id);

    Mono<EventDocument> blockDocument(String eventId);
}
