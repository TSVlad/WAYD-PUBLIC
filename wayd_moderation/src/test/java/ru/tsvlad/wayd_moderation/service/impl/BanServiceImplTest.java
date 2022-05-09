package ru.tsvlad.wayd_moderation.service.impl;

import org.junit.jupiter.api.Test;
import org.mockito.ArgumentMatcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;
import ru.tsvlad.wayd_moderation.BaseIntegrationTest;
import ru.tsvlad.wayd_moderation.common.BanCreation;
import ru.tsvlad.wayd_moderation.document.BanDocument;
import ru.tsvlad.wayd_moderation.document.ReasonDocument;
import ru.tsvlad.wayd_moderation.enums.BanType;
import ru.tsvlad.wayd_moderation.messaging.producer.ModerationServiceProducer;
import ru.tsvlad.wayd_moderation.repository.BanRepository;
import ru.tsvlad.wayd_moderation.service.ReasonService;

import java.time.LocalDate;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@SpringBootTest
class BanServiceImplTest extends BaseIntegrationTest {

    @Autowired
    BanServiceImpl banService;

    @MockBean
    ReasonService reasonService;
    @MockBean
    BanRepository banRepository;
    @MockBean
    ModerationServiceProducer moderationServiceProducer;

    @Test
    void banUserUndeterminedTest() {
        BanCreation banCreation = BanCreation.builder()
                .userId("1")
                .moderatorId("2")
                .comment("comment")
                .reason("ABUSE")
                .banDuration(10)
                .build();
        ReasonDocument reasonDocument = ReasonDocument.builder()
                .id("id")
                .banType(BanType.UNDETERMINED)
                .name("ABUSE")
                .build();
        BanDocument banDocument = BanDocument.builder()
                .id("1")
                .userId("1")
                .comment("comment")
                .moderatorId("2")
                .reason("ABUSE")
                .build();

        when(reasonService.getReasonByName("ABUSE")).thenReturn(Mono.just(reasonDocument));
        when(banRepository.save(any())).thenReturn(Mono.just(banDocument));

        StepVerifier.create(banService.banUser(banCreation)).expectNext(banDocument).verifyComplete();
    }

    @Test
    void banUserDeterminedTest() {
        BanCreation banCreation = BanCreation.builder()
                .userId("1")
                .moderatorId("2")
                .comment("comment")
                .reason("ABUSE")
                .banDuration(10)
                .build();
        ReasonDocument reasonDocument = ReasonDocument.builder()
                .id("id")
                .banType(BanType.DETERMINED)
                .name("ABUSE")
                .baseBanDuration(5)
                .build();
        BanDocument banDocument = BanDocument.builder()
                .id("1")
                .userId("1")
                .comment("comment")
                .moderatorId("2")
                .reason("ABUSE")
                .build();

        when(reasonService.getReasonByName("ABUSE")).thenReturn(Mono.just(reasonDocument));
        when(banRepository.save(any())).thenReturn(Mono.just(banDocument));
        when(banRepository.findAllByUserId("1")).thenReturn(Flux.empty());

        StepVerifier.create(banService.banUser(banCreation)).expectNext(banDocument).verifyComplete();
    }

    @Test
    void banUserPermanentTest() {
        BanCreation banCreation = BanCreation.builder()
                .userId("1")
                .moderatorId("2")
                .comment("comment")
                .reason("ABUSE")
                .banDuration(10)
                .build();
        ReasonDocument reasonDocument = ReasonDocument.builder()
                .id("id")
                .banType(BanType.PERMANENT)
                .name("ABUSE")
                .build();
        BanDocument banDocument = BanDocument.builder()
                .id("1")
                .userId("1")
                .comment("comment")
                .moderatorId("2")
                .reason("ABUSE")
                .build();

        when(reasonService.getReasonByName("ABUSE")).thenReturn(Mono.just(reasonDocument));
        when(banRepository.save(any())).thenReturn(Mono.just(banDocument));

        StepVerifier.create(banService.banUser(banCreation)).expectNext(banDocument).verifyComplete();
    }

    @Test
    void unBanUsersTest() {
        List<BanDocument> banDocuments = List.of(
                BanDocument.builder().userId("1").build(),
                BanDocument.builder().userId("2").build(),
                BanDocument.builder().userId("3").build()
        );
        BanDocument banDocumentLater = BanDocument.builder().build();

        when(banRepository.findAllByBanUntil(any())).thenReturn(Flux.fromIterable(banDocuments));
        when(banRepository.findAllByUserIdAndBanUntilAfter(eq("1"), any())).thenReturn(Flux.empty());
        when(banRepository.findAllByUserIdAndBanUntilAfter(eq("2"), any())).thenReturn(Flux.empty());
        when(banRepository.findAllByUserIdAndBanUntilAfter(eq("3"), any())).thenReturn(Flux.just(banDocumentLater));

        banService.unBanUsers();
        verify(moderationServiceProducer).unbanUser(banDocuments.get(0));
        verify(moderationServiceProducer).unbanUser(banDocuments.get(1));
        verify(moderationServiceProducer, times(0)).unbanUser(banDocuments.get(2));
    }
}