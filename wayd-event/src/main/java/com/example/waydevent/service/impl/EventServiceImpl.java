package com.example.waydevent.service.impl;

import com.example.waydevent.business.RateEvent;
import com.example.waydevent.business.UserInfo;
import com.example.waydevent.document.EventDocument;
import com.example.waydevent.enums.EventStatus;
import com.example.waydevent.messaging.consumer.dto.Validity;
import com.example.waydevent.messaging.producer.EventServiceProducer;
import com.example.waydevent.repository.EventRepository;
import com.example.waydevent.restapi.controller.advice.exceptions.ForbiddenException;
import com.example.waydevent.restapi.dto.EventDTO;
import com.example.waydevent.restapi.dto.EventFilterDTO;
import com.example.waydevent.restapi.dto.EventForCreateAndUpdateDTO;
import com.example.waydevent.service.EventService;
import com.example.waydevent.util.MappingUtils;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDate;
import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {

    private final ModelMapper modelMapper;
    private final EventRepository eventRepository;
    private final EventServiceProducer eventServiceProducer;

    @Override
    public Mono<EventDTO> saveEvent(EventForCreateAndUpdateDTO eventDTO, UserInfo userInfo) {
        if (eventDTO.getId() == null) {
            return createEvent(eventDTO, userInfo);
        } else {
            return updateEvent(eventDTO, userInfo);
        }
    }

    private Mono<EventDTO> createEvent(EventForCreateAndUpdateDTO eventForCreateAndUpdateDTO, UserInfo userInfo) {
        EventDocument eventDocument = EventDocument.createEvent(eventForCreateAndUpdateDTO, userInfo);
        return eventRepository.save(eventDocument)
                .map(document -> {
                    EventDTO dto = modelMapper.map(document, EventDTO.class);
                    eventServiceProducer.createEvent(dto, userInfo);
                    return dto;
                });
    }

    private Mono<EventDTO> updateEvent(EventForCreateAndUpdateDTO eventForCreateAndUpdateDTO, UserInfo userInfo) {
        return eventRepository.findById(eventForCreateAndUpdateDTO.getId())
                .flatMap(eventDocument -> {
                    if (!userInfo.getId().equals(eventDocument.getOwnerId())) {
                        return Mono.error(new ForbiddenException());
                    }
                    eventDocument.updateEvent(eventForCreateAndUpdateDTO);
                    return eventRepository.save(eventDocument);
                }).map(document -> {
                    EventDTO eventDTO = modelMapper.map(document, EventDTO.class);
                    eventServiceProducer.updateEvent(eventDTO, userInfo);
                    return eventDTO;
                });
    }

    @Override
    public Flux<EventDTO> getEventsInPolygonForFilters(EventFilterDTO eventFilterDTO, LocalDate finderDateOfBirth) {
        return filter(eventRepository.findAllByPointWithinAndDateTimeAfter(eventFilterDTO.getGeoJsonPolygon(), ZonedDateTime.now())
                .filter(event -> event.getStatus() == EventStatus.ACTIVE), eventFilterDTO, finderDateOfBirth)
                .map(document -> modelMapper.map(document, EventDTO.class));
    }

    @Override
    public Flux<EventDTO> getEventsForUserId(String id) {
        return eventRepository.findAllByOwnerId(id).filter(event -> event.getStatus() == EventStatus.ACTIVE)
                .map(document -> modelMapper.map(document, EventDTO.class));
    }

    @Override
    public Flux<EventDocument> getEventsForParticipantId(String id) {
        return eventRepository.findAllByParticipantsIdsContaining(id)
                .filter(eventDocument -> eventDocument.getStatus() == EventStatus.ACTIVE);
    }

    @Override
    public Flux<EventDTO> getEventsForIds(List<String> ids) {
        return eventRepository.findAllByIdIn(ids).map(eventDocument -> MappingUtils.map(eventDocument, EventDTO.class));
    }

    @Override
    public Mono<EventDocument> getEventById(String id) {
        return eventRepository.findById(id);
    }

    @Override
    public Mono<EventDTO> addParticipant(String eventId, UserInfo userInfo) {
        return eventRepository.findById(eventId)
                .flatMap(eventDocument -> {
                    eventDocument.addParticipant(userInfo);
                    return eventRepository.save(eventDocument);
                }).map(eventDocument -> {
                    return MappingUtils.map(eventDocument, EventDTO.class);
                });
    }

    @Override
    public Mono<EventDocument> cancelParticipation(String eventId, UserInfo userInfo) {
        return eventRepository.findById(eventId)
                .flatMap(eventDocument -> {
                    eventDocument.cancelParticipation(userInfo.getId());
                    return eventRepository.save(eventDocument);
                });
    }

    private Flux<EventDocument> filter(Flux<EventDocument> eventDTOFlux, EventFilterDTO eventFilterDTO, LocalDate finderDateOfBirth) {
        return eventDTOFlux.filter(event -> {
            if (eventFilterDTO.getCategory() != null) {
                if (!event.getCategory().equals(eventFilterDTO.getCategory())) {
                    return false;
                }
            }
            if (eventFilterDTO.getSubcategory() != null) {
                if (!event.getSubCategory().equals(eventFilterDTO.getSubcategory())) {
                    return false;
                }
            }
            if (eventFilterDTO.getDateAfter() != null) {
                if (!event.getDateTime().isAfter(eventFilterDTO.getDateAfter())) {
                    return false;
                }
            }
            if (eventFilterDTO.getDateBefore() != null) {
                if (!event.getDateTime().isBefore(eventFilterDTO.getDateBefore().plus(1, ChronoUnit.DAYS))) {
                    return false;
                }
            }
            if (finderDateOfBirth != null) {
                if (!LocalDate.now().minus(event.getMinAge(), ChronoUnit.YEARS).isAfter(finderDateOfBirth) ||
                        event.getMaxAge() > 0 && !LocalDate.now().minus(event.getMaxAge(), ChronoUnit.YEARS).isBefore(finderDateOfBirth)) {
                    return false;
                }
            }
            if (event.getDeadline() != null) {
                event.getDeadline().isAfter(ZonedDateTime.now());
            }
            return true;
        });
    }

    @Override
    public void updateValidity(String id, Validity validity, UserInfo userInfo) {
        eventRepository.findById(id).flatMap(eventDocument -> {
            eventDocument.updateValidity(validity);
            return eventRepository.save(eventDocument);
        }).doOnNext(eventDocument -> {
            eventServiceProducer.eventValidated(modelMapper.map(eventDocument, EventDTO.class), userInfo);
        }).subscribe();
    }

    @Override
    public Mono<EventDocument> rateEvent(RateEvent rateEvent, String id) {
        return eventRepository.findById(rateEvent.getEventId()).flatMap(eventDocument -> {
            if (eventDocument.getDateTime().isAfter(ZonedDateTime.now())
                    || !eventDocument.getParticipantsIds().contains(id)) {
                return Mono.error(new ForbiddenException());
            }
            if (eventDocument.getRates() == null) {
                eventDocument.setRates(new HashMap<>());
            }
            eventDocument.getRates().put(id, rateEvent.getRate());
            return eventRepository.save(eventDocument);
        });
    }

    @Override
    public Mono<EventDocument> blockDocument(String eventId) {
        return eventRepository.findById(eventId)
                .flatMap(eventDocument -> {
                    eventDocument.block();
                    return eventRepository.save(eventDocument);
                });
    }
}
