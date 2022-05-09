package com.example.waydevent.service.impl;

import com.example.waydevent.BaseIntegrationTest;
import com.example.waydevent.business.RateEvent;
import com.example.waydevent.business.UserInfo;
import com.example.waydevent.config.security.Role;
import com.example.waydevent.document.EventDocument;
import com.example.waydevent.enums.EventStatus;
import com.example.waydevent.enums.EventType;
import com.example.waydevent.messaging.consumer.dto.Validity;
import com.example.waydevent.repository.EventRepository;
import com.example.waydevent.restapi.controller.advice.exceptions.ForbiddenException;
import com.example.waydevent.restapi.controller.advice.exceptions.InvalidAgeException;
import com.example.waydevent.restapi.controller.advice.exceptions.TooManyParticipantsException;
import com.example.waydevent.restapi.dto.EventDTO;
import com.example.waydevent.restapi.dto.EventForCreateAndUpdateDTO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static org.mockito.Mockito.when;

@SpringBootTest
class EventServiceImplTest extends BaseIntegrationTest {

    @MockBean
    EventRepository eventRepository;

    @Autowired
    EventServiceImpl eventService;

    @Test
    void saveEventCreateTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventForCreateAndUpdateDTO eventForCreateAndUpdateDTO = EventForCreateAndUpdateDTO.builder()
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .build();
        UserInfo userInfo = UserInfo.builder()
                .id("1")
                .roles(List.of(Role.ROLE_PERSON))
                .build();
        EventDocument eventDocument = EventDocument.builder()
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();
        EventDocument saveResult = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();
        EventDTO expectedResult = EventDTO.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();

        when(eventRepository.save(eventDocument)).thenReturn(Mono.just(saveResult));

        StepVerifier.create(eventService.saveEvent(eventForCreateAndUpdateDTO, userInfo))
                .expectNext(expectedResult)
                .verifyComplete();
    }

    @Test
    void saveEventUpdateTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventForCreateAndUpdateDTO eventForCreateAndUpdateDTO = EventForCreateAndUpdateDTO.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .build();
        UserInfo userInfo = UserInfo.builder()
                .id("1")
                .roles(List.of(Role.ROLE_PERSON))
                .build();
        EventDocument eventDocumentInDb = EventDocument.builder()
                .id("1")
                .name("name1")
                .category("category1")
                .contacts("contacts1")
                .dateTime(date)
                .description("description1")
                .picturesRefs(List.of("pic11", "pic21"))
                .subCategory("subcategory1")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();
        EventDocument eventDocument = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();
        EventDocument saveResult = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();
        EventDTO expectedResult = EventDTO.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();

        when(eventRepository.findById("1")).thenReturn(Mono.just(eventDocumentInDb));
        when(eventRepository.save(eventDocument)).thenReturn(Mono.just(saveResult));

        StepVerifier.create(eventService.saveEvent(eventForCreateAndUpdateDTO, userInfo))
                .expectNext(expectedResult)
                .verifyComplete();
    }

    @Test
    void saveEventUpdateForbiddenTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventForCreateAndUpdateDTO eventForCreateAndUpdateDTO = EventForCreateAndUpdateDTO.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .build();
        UserInfo userInfo = UserInfo.builder()
                .id("1")
                .roles(List.of(Role.ROLE_PERSON))
                .build();
        EventDocument eventDocumentInDb = EventDocument.builder()
                .id("1")
                .name("name1")
                .category("category1")
                .contacts("contacts1")
                .dateTime(date)
                .description("description1")
                .picturesRefs(List.of("pic11", "pic21"))
                .subCategory("subcategory1")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("2")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();
        EventDocument eventDocument = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();
        EventDocument saveResult = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();

        when(eventRepository.findById("1")).thenReturn(Mono.just(eventDocumentInDb));
        when(eventRepository.save(eventDocument)).thenReturn(Mono.just(saveResult));

        StepVerifier.create(eventService.saveEvent(eventForCreateAndUpdateDTO, userInfo))
                .expectError(ForbiddenException.class)
                .verify();
    }

    @Test
    void getEventsForUserIdTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        List<EventDocument> documents = List.of(
                EventDocument.builder()
                        .id("1")
                        .name("name")
                        .category("category")
                        .contacts("contacts")
                        .dateTime(date)
                        .description("description")
                        .picturesRefs(List.of("pic1", "pic2"))
                        .subCategory("subcategory")
                        .status(EventStatus.ACTIVE)
                        .validity(Validity.VALID)
                        .ownerId("1")
                        .type(EventType.PERSONAL)
                        .participantsIds(new HashSet<>())
                        .rates(new HashMap<>())
                        .build(),
                EventDocument.builder()
                        .id("2")
                        .name("name")
                        .category("category")
                        .contacts("contacts")
                        .dateTime(date)
                        .description("description")
                        .picturesRefs(List.of("pic1", "pic2"))
                        .subCategory("subcategory")
                        .status(EventStatus.ACTIVE)
                        .validity(Validity.VALID)
                        .ownerId("1")
                        .type(EventType.PERSONAL)
                        .participantsIds(new HashSet<>())
                        .rates(new HashMap<>())
                        .build(),
                EventDocument.builder()
                        .id("3")
                        .name("name")
                        .category("category")
                        .contacts("contacts")
                        .dateTime(date)
                        .description("description")
                        .picturesRefs(List.of("pic1", "pic2"))
                        .subCategory("subcategory")
                        .status(EventStatus.ON_VALIDATION)
                        .validity(Validity.NOT_VALIDATED)
                        .ownerId("1")
                        .type(EventType.PERSONAL)
                        .participantsIds(new HashSet<>())
                        .rates(new HashMap<>())
                        .build()
        );

        List<EventDTO> expectedResult = List.of(
                EventDTO.builder()
                        .id("1")
                        .name("name")
                        .category("category")
                        .contacts("contacts")
                        .dateTime(date)
                        .description("description")
                        .picturesRefs(List.of("pic1", "pic2"))
                        .subCategory("subcategory")
                        .status(EventStatus.ACTIVE)
                        .validity(Validity.VALID)
                        .ownerId("1")
                        .type(EventType.PERSONAL)
                        .participantsIds(new HashSet<>())
                        .rates(new HashMap<>())
                        .build(),
        EventDTO.builder()
                .id("2")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build()
        );

        when(eventRepository.findAllByOwnerId("1")).thenReturn(Flux.fromIterable(documents));

        StepVerifier.create(eventService.getEventsForUserId("1"))
                .expectNext(expectedResult.get(0))
                .expectNext(expectedResult.get(1))
                .verifyComplete();
    }

    @Test
    void getEventsForParticipantIdTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        List<EventDocument> documents = List.of(
                EventDocument.builder()
                        .id("1")
                        .name("name")
                        .category("category")
                        .contacts("contacts")
                        .dateTime(date)
                        .description("description")
                        .picturesRefs(List.of("pic1", "pic2"))
                        .subCategory("subcategory")
                        .status(EventStatus.ACTIVE)
                        .validity(Validity.VALID)
                        .ownerId("1")
                        .type(EventType.PERSONAL)
                        .participantsIds(new HashSet<>())
                        .rates(new HashMap<>())
                        .build(),
                EventDocument.builder()
                        .id("2")
                        .name("name")
                        .category("category")
                        .contacts("contacts")
                        .dateTime(date)
                        .description("description")
                        .picturesRefs(List.of("pic1", "pic2"))
                        .subCategory("subcategory")
                        .status(EventStatus.ACTIVE)
                        .validity(Validity.VALID)
                        .ownerId("1")
                        .type(EventType.PERSONAL)
                        .participantsIds(new HashSet<>())
                        .rates(new HashMap<>())
                        .build()
        );

        when(eventRepository.findAllByParticipantsIdsContaining("1")).thenReturn(Flux.fromIterable(documents));

        StepVerifier.create(eventService.getEventsForParticipantId("1"))
                .expectNext(documents.get(0))
                .expectNext(documents.get(1))
                .verifyComplete();
    }

    @Test
    void getEventsForIdsTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        List<EventDocument> documents = List.of(
                EventDocument.builder()
                        .id("1")
                        .name("name")
                        .category("category")
                        .contacts("contacts")
                        .dateTime(date)
                        .description("description")
                        .picturesRefs(List.of("pic1", "pic2"))
                        .subCategory("subcategory")
                        .status(EventStatus.ACTIVE)
                        .validity(Validity.VALID)
                        .ownerId("1")
                        .type(EventType.PERSONAL)
                        .participantsIds(new HashSet<>())
                        .rates(new HashMap<>())
                        .build(),
                EventDocument.builder()
                        .id("2")
                        .name("name")
                        .category("category")
                        .contacts("contacts")
                        .dateTime(date)
                        .description("description")
                        .picturesRefs(List.of("pic1", "pic2"))
                        .subCategory("subcategory")
                        .status(EventStatus.ACTIVE)
                        .validity(Validity.VALID)
                        .ownerId("1")
                        .type(EventType.PERSONAL)
                        .participantsIds(new HashSet<>())
                        .rates(new HashMap<>())
                        .build()
        );

        List<EventDTO> expectedResult = List.of(
                EventDTO.builder()
                        .id("1")
                        .name("name")
                        .category("category")
                        .contacts("contacts")
                        .dateTime(date)
                        .description("description")
                        .picturesRefs(List.of("pic1", "pic2"))
                        .subCategory("subcategory")
                        .status(EventStatus.ACTIVE)
                        .validity(Validity.VALID)
                        .ownerId("1")
                        .type(EventType.PERSONAL)
                        .participantsIds(new HashSet<>())
                        .rates(new HashMap<>())
                        .build(),
                EventDTO.builder()
                        .id("2")
                        .name("name")
                        .category("category")
                        .contacts("contacts")
                        .dateTime(date)
                        .description("description")
                        .picturesRefs(List.of("pic1", "pic2"))
                        .subCategory("subcategory")
                        .status(EventStatus.ACTIVE)
                        .validity(Validity.VALID)
                        .ownerId("1")
                        .type(EventType.PERSONAL)
                        .participantsIds(new HashSet<>())
                        .rates(new HashMap<>())
                        .build()
        );

        when(eventRepository.findAllByIdIn(List.of("1", "2", "3"))).thenReturn(Flux.fromIterable(documents));

        StepVerifier.create(eventService.getEventsForIds(List.of("1", "2", "3")))
                .expectNext(expectedResult.get(0))
                .expectNext(expectedResult.get(1))
                .verifyComplete();
    }

    @Test
    void getEventByIdTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventDocument document = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();

        when(eventRepository.findById("1")).thenReturn(Mono.just(document));

        StepVerifier.create(eventService.getEventById("1"))
                .expectNext(document)
                .verifyComplete();
    }

    @Test
    void addParticipantTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventDocument document = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();
        UserInfo userInfo = UserInfo.builder()
                .id("1")
                .dateOfBirth(LocalDate.of(1990, 1, 1))
                .build();

        EventDocument documentAfter = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(Set.of("1"))
                .rates(new HashMap<>())
                .build();
        EventDTO expectedResult = EventDTO.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(Set.of("1"))
                .rates(new HashMap<>())
                .build();

        when(eventRepository.findById("1")).thenReturn(Mono.just(document));
        when(eventRepository.save(documentAfter)).thenReturn(Mono.just(documentAfter));

        StepVerifier.create(eventService.addParticipant("1", userInfo))
                .expectNext(expectedResult)
                .verifyComplete();
    }

    @Test
    void addParticipantInvalidAgeTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventDocument document = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("1")
                .minAge(18)
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>())
                .rates(new HashMap<>())
                .build();
        UserInfo userInfo = UserInfo.builder()
                .id("1")
                .dateOfBirth(LocalDate.of(2020, 1, 1))
                .build();

        when(eventRepository.findById("1")).thenReturn(Mono.just(document));

        StepVerifier.create(eventService.addParticipant("1", userInfo))
                .expectError(InvalidAgeException.class)
                .verify();
    }

    @Test
    void addParticipantTooManyParticipantsTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventDocument document = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .maxNumberOfParticipants(3)
                .participantsIds(Set.of("2", "3", "4"))
                .rates(new HashMap<>())
                .build();
        UserInfo userInfo = UserInfo.builder()
                .id("1")
                .dateOfBirth(LocalDate.of(1990, 1, 1))
                .build();

        when(eventRepository.findById("1")).thenReturn(Mono.just(document));

        StepVerifier.create(eventService.addParticipant("1", userInfo))
                .expectError(TooManyParticipantsException.class)
                .verify();
    }

    @Test
    void cancelParticipationTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventDocument document = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>(Set.of("2", "3", "4")))
                .rates(new HashMap<>())
                .build();
        UserInfo userInfo = UserInfo.builder()
                .id("2")
                .dateOfBirth(LocalDate.of(1990, 1, 1))
                .build();
        EventDocument documentAfter = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(Set.of("3", "4"))
                .rates(new HashMap<>())
                .build();

        when(eventRepository.findById("1")).thenReturn(Mono.just(document));
        when(eventRepository.save(documentAfter)).thenReturn(Mono.just(documentAfter));

        StepVerifier.create(eventService.cancelParticipation("1", userInfo))
                .expectNext(documentAfter)
                .verifyComplete();
    }

    @Test
    void updateValidityTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventDocument document = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>(Set.of("2", "3", "4")))
                .rates(new HashMap<>())
                .build();

        UserInfo userInfo = UserInfo.builder()
                .id("2")
                .dateOfBirth(LocalDate.of(1990, 1, 1))
                .build();

        EventDocument documentAfter = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ACTIVE)
                .validity(Validity.VALID)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>(Set.of("2", "3", "4")))
                .rates(new HashMap<>())
                .build();

        when(eventRepository.findById("1")).thenReturn(Mono.just(document));
        when(eventRepository.save(documentAfter)).thenReturn(Mono.just(documentAfter));
        eventService.updateValidity("1", Validity.VALID, userInfo);
    }

    @Test
    void rateEventTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventDocument document = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>(Set.of("2", "3", "4")))
                .rates(new HashMap<>())
                .build();
        EventDocument documentAfter = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>(Set.of("2", "3", "4")))
                .rates(new HashMap<>())
                .build();
        documentAfter.getRates().put("2", 10);

        when(eventRepository.findById("1")).thenReturn(Mono.just(document));
        when(eventRepository.save(documentAfter)).thenReturn(Mono.just(documentAfter));

        StepVerifier.create(eventService.rateEvent(new RateEvent("1", 10), "2"))
                .expectNext(documentAfter)
                .verifyComplete();
    }

    @Test
    void rateEventForbiddenTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventDocument document = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>(Set.of("2", "3", "4")))
                .rates(new HashMap<>())
                .build();
        EventDocument documentAfter = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>(Set.of("2", "3", "4")))
                .rates(new HashMap<>())
                .build();
        documentAfter.getRates().put("2", 10);

        when(eventRepository.findById("1")).thenReturn(Mono.just(document));
        when(eventRepository.save(documentAfter)).thenReturn(Mono.just(documentAfter));

        StepVerifier.create(eventService.rateEvent(new RateEvent("1", 10), "7"))
                .expectError(ForbiddenException.class)
                .verify();
    }

    @Test
    void blockDocumentTest() {
        ZonedDateTime date = ZonedDateTime.now().minus(5, ChronoUnit.DAYS);
        EventDocument document = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.ON_VALIDATION)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>(Set.of("2", "3", "4")))
                .rates(new HashMap<>())
                .build();
        EventDocument documentAfter = EventDocument.builder()
                .id("1")
                .name("name")
                .category("category")
                .contacts("contacts")
                .dateTime(date)
                .description("description")
                .picturesRefs(List.of("pic1", "pic2"))
                .subCategory("subcategory")
                .status(EventStatus.BLOCKED_BY_MODERATOR)
                .validity(Validity.NOT_VALIDATED)
                .ownerId("1")
                .type(EventType.PERSONAL)
                .participantsIds(new HashSet<>(Set.of("2", "3", "4")))
                .rates(new HashMap<>())
                .build();

        when(eventRepository.findById("1")).thenReturn(Mono.just(document));
        when(eventRepository.save(documentAfter)).thenReturn(Mono.just(documentAfter));

        StepVerifier.create(eventService.blockDocument("1"))
                .expectNext(documentAfter)
                .verifyComplete();
    }
}