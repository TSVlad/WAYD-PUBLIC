package com.example.waydevent.service.impl;

import com.example.waydevent.document.EventCategoryDocument;
import com.example.waydevent.repository.EventCategoryRepository;
import com.example.waydevent.restapi.dto.EventCategoryDTO;
import com.example.waydevent.service.EventCategoryService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Service
@RequiredArgsConstructor
public class EventCategoryServiceImpl implements EventCategoryService {

    private final EventCategoryRepository eventCategoryRepository;
    private final ModelMapper modelMapper;

    @Override
    public Flux<EventCategoryDTO> getAllEventCategories() {
        return eventCategoryRepository.findAll().map(document -> modelMapper.map(document, EventCategoryDTO.class));
    }

    @Override
    public Mono<EventCategoryDTO> saveEventCategory(EventCategoryDTO eventCategoryDTO) {
        if (eventCategoryDTO.getId() == null) {
            return eventCategoryRepository.save(modelMapper.map(eventCategoryDTO, EventCategoryDocument.class))
                    .map(document -> modelMapper.map(document, EventCategoryDTO.class));
        } else {
            return eventCategoryRepository.findById(eventCategoryDTO.getId())
                    .flatMap(ec -> {
                        EventCategoryDocument document = modelMapper.map(eventCategoryDTO, EventCategoryDocument.class);
                        document.setVersion(ec.getVersion());
                        return eventCategoryRepository.save(document);
                    })
                    .map(document -> modelMapper.map(document, EventCategoryDTO.class));
        }
    }

    @Override
    public Mono<Void> deleteEventCategory(String id) {
        return eventCategoryRepository.deleteById(id);
    }
}
