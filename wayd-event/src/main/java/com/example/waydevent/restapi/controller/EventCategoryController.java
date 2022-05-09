package com.example.waydevent.restapi.controller;

import com.example.waydevent.restapi.dto.EventCategoryDTO;
import com.example.waydevent.service.EventCategoryService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import javax.validation.Valid;

@RestController
@RequestMapping("/event-category")
@AllArgsConstructor
@Slf4j
public class EventCategoryController {
    private EventCategoryService eventCategoryService;

    @GetMapping()
    public Flux<EventCategoryDTO> getAllEventCategories() {
        log.debug("Get all categories request gotten");
        return eventCategoryService.getAllEventCategories();
    }

    @PostMapping()
    public Mono<EventCategoryDTO> saveEventCategory(@Valid @RequestBody EventCategoryDTO eventCategoryDTO) {
        log.debug("Save event category request gotten");
        return eventCategoryService.saveEventCategory(eventCategoryDTO);
    }

    @DeleteMapping("/{id}")
    public Mono<Void> deleteCategory(@PathVariable String id) {
        log.debug("Delete event category request gotten");
        return eventCategoryService.deleteEventCategory(id);
    }
}
