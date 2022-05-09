package ru.tsvlad.wayd_moderation.service.impl;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;
import ru.tsvlad.wayd_moderation.BaseIntegrationTest;
import ru.tsvlad.wayd_moderation.common.ComplaintProcessing;
import ru.tsvlad.wayd_moderation.document.ComplaintDocument;
import ru.tsvlad.wayd_moderation.document.SessionDocument;
import ru.tsvlad.wayd_moderation.enums.ComplaintStatus;
import ru.tsvlad.wayd_moderation.enums.ComplaintType;
import ru.tsvlad.wayd_moderation.repository.ComplaintRepository;
import ru.tsvlad.wayd_moderation.service.SessionService;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@SpringBootTest
class ComplaintServiceImplTest extends BaseIntegrationTest {

    @Autowired
    ComplaintServiceImpl complaintService;

    @MockBean
    SessionService sessionService;
    @MockBean
    ComplaintRepository complaintRepository;

    @Test
    void createComplaintAndSetModeratorTest() {
        ComplaintDocument complaintDocument = ComplaintDocument.builder()
                .complainingUserId("2")
                .complaintStatus(ComplaintStatus.NEW)
                .objectId("id")
                .type(ComplaintType.COMPLAINT_EVENT)
                .message("message")
                .build();
        SessionDocument sessionDocument = SessionDocument.builder()
                .id("1")
                .moderatorId("1")
                .build();
        ComplaintDocument complaintDocumentAfter = ComplaintDocument.builder()
                .complainingUserId("2")
                .moderatorId("1")
                .complaintStatus(ComplaintStatus.NEW)
                .objectId("id")
                .type(ComplaintType.COMPLAINT_EVENT)
                .message("message")
                .build();

        when(sessionService.getRandomOpenSession()).thenReturn(Mono.just(sessionDocument));
        when(complaintRepository.save(complaintDocumentAfter)).thenReturn(Mono.just(complaintDocumentAfter));
        when(complaintRepository.save(complaintDocument)).thenReturn(Mono.just(complaintDocumentAfter));

        StepVerifier.create(complaintService.createComplaintAndSetModerator(complaintDocument))
                .expectNext(complaintDocumentAfter)
                .verifyComplete();
    }

    @Test
    void createComplaintAndSetModeratorWithoutOpenedSessionsTest() {
        ComplaintDocument complaintDocument = ComplaintDocument.builder()
                .complainingUserId("2")
                .complaintStatus(ComplaintStatus.NEW)
                .objectId("id")
                .type(ComplaintType.COMPLAINT_EVENT)
                .message("message")
                .build();

        when(sessionService.getRandomOpenSession()).thenReturn(Mono.empty());
        when(complaintRepository.save(complaintDocument)).thenReturn(Mono.just(complaintDocument));

        StepVerifier.create(complaintService.createComplaintAndSetModerator(complaintDocument))
                .expectNext(complaintDocument)
                .verifyComplete();
    }

    @Test
    void getComplaintsForModeratorTest() {
        List<ComplaintDocument> complaintDocuments = List.of(
                ComplaintDocument.builder()
                        .id("1")
                        .complainingUserId("2")
                        .complaintStatus(ComplaintStatus.NEW)
                        .objectId("id")
                        .type(ComplaintType.COMPLAINT_EVENT)
                        .message("message")
                        .build(),
                ComplaintDocument.builder()
                        .id("2")
                        .complainingUserId("2")
                        .complaintStatus(ComplaintStatus.NEW)
                        .objectId("id")
                        .type(ComplaintType.COMPLAINT_EVENT)
                        .message("message")
                        .build()
        );

        when(complaintRepository.findByModeratorIdAndComplaintStatusInAndTypeIn("1",
                List.of(ComplaintStatus.NEW), List.of(ComplaintType.COMPLAINT_EVENT)))
                .thenReturn(Flux.fromIterable(complaintDocuments));

        StepVerifier.create(complaintService.getComplaintsForModerator("1",
                        List.of(ComplaintStatus.NEW), List.of(ComplaintType.COMPLAINT_EVENT)))
                .expectNextSequence(complaintDocuments)
                .verifyComplete();
    }

    @Test
    void processComplaintTest() {
        ComplaintProcessing complaintProcessing = ComplaintProcessing.builder()
                .complaintId("1")
                .complaintStatus(ComplaintStatus.SOLVED)
                .moderatorComment("comment")
                .build();
        ComplaintDocument complaintDocument = ComplaintDocument.builder()
                .id("1")
                .complainingUserId("2")
                .complaintStatus(ComplaintStatus.NEW)
                .objectId("id")
                .type(ComplaintType.COMPLAINT_EVENT)
                .message("message")
                .build();
        ComplaintDocument complaintDocumentAfter = ComplaintDocument.builder()
                .id("1")
                .complainingUserId("2")
                .complaintStatus(ComplaintStatus.SOLVED)
                .objectId("id")
                .type(ComplaintType.COMPLAINT_EVENT)
                .message("message")
                .moderatorComment("comment")
                .build();

        when(complaintRepository.findById("1")).thenReturn(Mono.just(complaintDocument));
        when(complaintRepository.save(any())).thenReturn(Mono.just(complaintDocumentAfter));

        StepVerifier.create(complaintService.processComplaint(complaintProcessing, "3"))
                .expectNext(complaintDocumentAfter)
                .verifyComplete();
    }

    @Test
    void setModeratorsToComplaintsTest() {
        List<ComplaintDocument> complaintDocuments = List.of(
                ComplaintDocument.builder()
                        .id("1")
                        .complainingUserId("2")
                        .complaintStatus(ComplaintStatus.NEW)
                        .objectId("id")
                        .type(ComplaintType.COMPLAINT_EVENT)
                        .message("message")
                        .build(),
                ComplaintDocument.builder()
                        .id("2")
                        .complainingUserId("2")
                        .complaintStatus(ComplaintStatus.NEW)
                        .objectId("id")
                        .type(ComplaintType.COMPLAINT_EVENT)
                        .message("message")
                        .build()
        );
        SessionDocument sessionDocument = SessionDocument.builder()
                .id("1")
                .moderatorId("3")
                .build();
        List<ComplaintDocument> complaintDocumentsAfter = List.of(
                ComplaintDocument.builder()
                        .id("1")
                        .complainingUserId("2")
                        .complaintStatus(ComplaintStatus.NEW)
                        .objectId("id")
                        .type(ComplaintType.COMPLAINT_EVENT)
                        .message("message")
                        .moderatorId("3")
                        .build(),
                ComplaintDocument.builder()
                        .id("2")
                        .complainingUserId("2")
                        .complaintStatus(ComplaintStatus.NEW)
                        .objectId("id")
                        .type(ComplaintType.COMPLAINT_EVENT)
                        .message("message")
                        .moderatorId("3")
                        .build()
        );

        when(complaintRepository.findAllByModeratorIdIsNull()).thenReturn(Flux.fromIterable(complaintDocuments));
        when(sessionService.getRandomOpenSession()).thenReturn(Mono.just(sessionDocument));
        when(complaintRepository.save(complaintDocuments.get(0))).thenReturn(Mono.just(complaintDocuments.get(0)));
        when(complaintRepository.save(complaintDocuments.get(1))).thenReturn(Mono.just(complaintDocuments.get(1)));

        complaintService.setModeratorsToComplaints();

        verify(complaintRepository).save(complaintDocuments.get(0));
        verify(complaintRepository).save(complaintDocuments.get(1));
    }
}