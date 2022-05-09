package ru.tsvlad.wayd_moderation.service.impl;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;
import ru.tsvlad.wayd_moderation.BaseIntegrationTest;
import ru.tsvlad.wayd_moderation.document.SessionDocument;
import ru.tsvlad.wayd_moderation.repository.SessionRepository;
import ru.tsvlad.wayd_moderation.restapi.controller.advice.exceptions.ActiveSessionNotFoundException;
import ru.tsvlad.wayd_moderation.restapi.controller.advice.exceptions.SessionAlreadyOpenedException;

import java.time.ZonedDateTime;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@SpringBootTest
class SessionServiceImplTest extends BaseIntegrationTest {

    @Autowired
    SessionServiceImpl sessionService;

    @MockBean
    SessionRepository sessionRepository;

    @Test
    void startSessionTest() {
        SessionDocument sessionDocument = SessionDocument.builder()
                .moderatorId("1")
                .start(ZonedDateTime.now())
                .build();

        when(sessionRepository.findByModeratorIdAndEndIsNull("1")).thenReturn(Mono.empty());
        when(sessionRepository.save(any())).thenReturn(Mono.just(sessionDocument));

        StepVerifier.create(sessionService.startSession("1")).expectNext(sessionDocument).verifyComplete();
    }

    @Test
    void startSessionFailTest() {
        SessionDocument sessionDocument = SessionDocument.builder()
                .moderatorId("1")
                .start(ZonedDateTime.now())
                .build();

        when(sessionRepository.findByModeratorIdAndEndIsNull("1")).thenReturn(Mono.just(sessionDocument));
        when(sessionRepository.save(any())).thenReturn(Mono.just(sessionDocument));

        StepVerifier.create(sessionService.startSession("1"))
                .expectError(SessionAlreadyOpenedException.class).verify();
    }

    @Test
    void closeSessionTest() {
        SessionDocument sessionDocument = SessionDocument.builder()
                .moderatorId("1")
                .start(ZonedDateTime.now())
                .build();

        when(sessionRepository.findByModeratorIdAndEndIsNull("1")).thenReturn(Mono.just(sessionDocument));
        when(sessionRepository.save(any())).thenReturn(Mono.just(sessionDocument));

        StepVerifier.create(sessionService.closeSession("1")).expectNext(sessionDocument).verifyComplete();
    }

    @Test
    void closeSessionFailTest() {
        SessionDocument sessionDocument = SessionDocument.builder()
                .moderatorId("1")
                .start(ZonedDateTime.now())
                .build();

        when(sessionRepository.findByModeratorIdAndEndIsNull("1")).thenReturn(Mono.empty());
        when(sessionRepository.save(any())).thenReturn(Mono.just(sessionDocument));

        StepVerifier.create(sessionService.closeSession("1"))
                .expectError(ActiveSessionNotFoundException.class).verify();
    }

    @Test
    void getRandomOpenSessionTest() {
        List<SessionDocument> sessionDocuments = List.of(
                SessionDocument.builder()
                        .moderatorId("1")
                        .start(ZonedDateTime.now())
                        .build(),
                SessionDocument.builder()
                        .moderatorId("2")
                        .start(ZonedDateTime.now())
                        .build()
        );

        when(sessionRepository.findAllByEndIsNull()).thenReturn(Flux.fromIterable(sessionDocuments));

        StepVerifier.create(sessionService.getRandomOpenSession())
                .expectNextCount(1)
                .verifyComplete();
    }

    @Test
    void getRandomOpenSessionFailTest() {
        when(sessionRepository.findAllByEndIsNull()).thenReturn(Flux.empty());

        StepVerifier.create(sessionService.getRandomOpenSession())
                .verifyComplete();
    }

    @Test
    void getCurrentSession() {
        SessionDocument sessionDocument = SessionDocument.builder()
                .moderatorId("1")
                .start(ZonedDateTime.now())
                .build();

        when(sessionRepository.findByModeratorIdAndEndIsNull("1")).thenReturn(Mono.just(sessionDocument));

        StepVerifier.create(sessionService.getCurrentSession("1"))
                .expectNext(sessionDocument)
                .verifyComplete();
    }
}