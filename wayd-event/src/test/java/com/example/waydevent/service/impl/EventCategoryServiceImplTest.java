package com.example.waydevent.service.impl;

import com.example.waydevent.BaseIntegrationTest;
import com.example.waydevent.document.EventCategoryDocument;
import com.example.waydevent.repository.EventCategoryRepository;
import com.example.waydevent.restapi.dto.EventCategoryDTO;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.util.List;

import static org.mockito.Mockito.when;

@SpringBootTest
class EventCategoryServiceImplTest extends BaseIntegrationTest {

    @Autowired
    EventCategoryServiceImpl eventCategoryService;

    @MockBean
    EventCategoryRepository eventCategoryRepository;

    @Test
    void getAllEventCategories() {
        List<EventCategoryDocument> categoryDocuments = List.of(
                EventCategoryDocument.builder().id("1").categoryName("name1").build(),
                EventCategoryDocument.builder().id("2").categoryName("name2").build(),
                EventCategoryDocument.builder().id("3").categoryName("name3").build()
        );
        List<EventCategoryDTO> expectedResult = List.of(
                EventCategoryDTO.builder().id("1").categoryName("name1").build(),
                EventCategoryDTO.builder().id("2").categoryName("name2").build(),
                EventCategoryDTO.builder().id("3").categoryName("name3").build()
        );

        when(eventCategoryRepository.findAll()).thenReturn(Flux.fromIterable(categoryDocuments));

        StepVerifier.create(eventCategoryService.getAllEventCategories())
                .expectNextSequence(expectedResult)
                .verifyComplete();
    }

    @Test
    void saveEventCreateCategory() {
        EventCategoryDTO eventCategoryDTO = EventCategoryDTO.builder().categoryName("name1").build();
        EventCategoryDocument eventCategoryDocument = EventCategoryDocument.builder().categoryName("name1").build();
        EventCategoryDocument documentAfter = EventCategoryDocument.builder().id("1").categoryName("name1").build();
        EventCategoryDTO expectedResult = EventCategoryDTO.builder().id("1").categoryName("name1").build();

        when(eventCategoryRepository.save(eventCategoryDocument)).thenReturn(Mono.just(documentAfter));

        StepVerifier.create(eventCategoryService.saveEventCategory(eventCategoryDTO))
                .expectNext(expectedResult)
                .verifyComplete();
    }

    @Test
    void saveEventUpdateCategory() {
        EventCategoryDTO eventCategoryDTO = EventCategoryDTO.builder().id("1").categoryName("name2").build();
        EventCategoryDocument eventCategoryDocument = EventCategoryDocument.builder().id("1").categoryName("name1").build();
        EventCategoryDocument documentAfter = EventCategoryDocument.builder().id("1").categoryName("name2").build();
        EventCategoryDTO expectedResult = EventCategoryDTO.builder().id("1").categoryName("name2").build();

        when(eventCategoryRepository.findById("1")).thenReturn(Mono.just(eventCategoryDocument));
        when(eventCategoryRepository.save(documentAfter)).thenReturn(Mono.just(documentAfter));

        StepVerifier.create(eventCategoryService.saveEventCategory(eventCategoryDTO))
                .expectNext(expectedResult)
                .verifyComplete();
    }

    @Test
    void deleteEventCategory() {
        when(eventCategoryRepository.deleteById("1")).thenReturn(Mono.empty());

        StepVerifier.create(eventCategoryService.deleteEventCategory("1"))
                .verifyComplete();
    }
}