package com.example.waydevent.service;

import com.example.waydevent.restapi.dto.EventCategoryDTO;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface EventCategoryService {
    Flux<EventCategoryDTO> getAllEventCategories();

    Mono<EventCategoryDTO> saveEventCategory(EventCategoryDTO eventCategoryDTO);

    Mono<Void> deleteEventCategory(String id);
}
