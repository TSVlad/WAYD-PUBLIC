package com.example.waydevent.restapi.controller;

import com.example.waydevent.business.RateEvent;
import com.example.waydevent.restapi.dto.EventDTO;
import com.example.waydevent.restapi.dto.EventFilterDTO;
import com.example.waydevent.restapi.dto.EventForCreateAndUpdateDTO;
import com.example.waydevent.restapi.dto.RateEventDTO;
import com.example.waydevent.service.AuthenticationService;
import com.example.waydevent.service.EventService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/event")
@AllArgsConstructor
@Slf4j
public class EventController {

    private final EventService eventService;
    private final ModelMapper modelMapper;
    private final AuthenticationService authenticationService;

    @PostMapping
    public Mono<EventDTO> saveEvent(@Valid @RequestBody EventForCreateAndUpdateDTO eventDTO, Authentication authentication) {
        log.debug("Save event request gotten for event {}", eventDTO);
        return eventService.saveEvent(eventDTO, authenticationService.getUserInfo(authentication));
    }

    @PostMapping("/all-in-poly")
    public Flux<EventDTO> getEventsInPolygon(@Valid @RequestBody EventFilterDTO eventFilterDTO, Authentication authentication) {
        log.debug("Get events in polygon request gotten for filters {}", eventFilterDTO);
        LocalDate dateOfBirth = null;
        if (authentication != null) {
            dateOfBirth = authenticationService.getUserInfo(authentication).getDateOfBirth();
        }
        return eventService.getEventsInPolygonForFilters(eventFilterDTO, dateOfBirth);
    }

    @GetMapping("/user/{id}")
    public Flux<EventDTO> getEventsForUserId(@PathVariable String id) {
        log.debug("Get event by id request gotten for id {}", id);
        return eventService.getEventsForUserId(id);
    }

    @GetMapping("/participant/{id}")
    public Flux<EventDTO> getEventsForParticipantId(@PathVariable String id) {
        log.debug("Get events by participants id request gotten for id {}", id);
        return eventService.getEventsForParticipantId(id).map(eventDocument -> modelMapper.map(eventDocument, EventDTO.class));
    }

    @PostMapping("/for-ids")
    public Flux<EventDTO> getEventsForIds(@NotNull @RequestBody List<String> ids) {
        return eventService.getEventsForIds(ids);
    }

    @GetMapping("/{id}")
    public Mono<EventDTO> getEventById(@PathVariable String id) { //TODO: secure (check for ACTIVE or owner)
        log.debug("Get event by id request gotten for id {}", id);
        return eventService.getEventById(id).map(eventDocument -> modelMapper.map(eventDocument, EventDTO.class));
    }

    @PostMapping("/participate/{eventId}")
    public Mono<EventDTO> participate(@NotNull @NotEmpty @PathVariable String eventId, Authentication authentication) {
        log.debug("Participate request gotten for event id {}", eventId);
        return eventService.addParticipant(eventId, authenticationService.getUserInfo(authentication));
    }

    @PostMapping("/participate/{eventId}/cancel")
    public Mono<EventDTO> cancelParticipation(@NotNull @NotEmpty @PathVariable String eventId, Authentication authentication) {
        log.debug("Cancel participation request gotten for event id {}", eventId);
        return eventService.cancelParticipation(eventId, authenticationService.getUserInfo(authentication))
                .map(eventDocument -> modelMapper.map(eventDocument, EventDTO.class));
    }

    @PostMapping("/rate")
    public Mono<EventDTO> rateEvent(@RequestBody RateEventDTO rateEventDTO, Authentication authentication) {
        log.debug("Rate event request gotten {}", rateEventDTO);
        return eventService.rateEvent(modelMapper.map(rateEventDTO, RateEvent.class), authenticationService.getUserId(authentication))
                .map(eventDocument -> modelMapper.map(eventDocument, EventDTO.class));
    }
}
