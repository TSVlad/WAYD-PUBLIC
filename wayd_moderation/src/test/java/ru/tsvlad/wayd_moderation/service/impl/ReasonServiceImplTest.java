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
import ru.tsvlad.wayd_moderation.document.ReasonDocument;
import ru.tsvlad.wayd_moderation.enums.BanType;
import ru.tsvlad.wayd_moderation.repository.ReasonRepository;

import static org.mockito.Mockito.when;

@SpringBootTest
class ReasonServiceImplTest extends BaseIntegrationTest {

    @Autowired
    ReasonServiceImpl reasonService;

    @MockBean
    ReasonRepository reasonRepository;

    @Test
    void saveReasonTest() {
        ReasonDocument reasonDocument = ReasonDocument.builder()
                .baseBanDuration(10)
                .name("NAME")
                .banType(BanType.DETERMINED)
                .build();

        when(reasonRepository.save(reasonDocument)).thenReturn(Mono.just(reasonDocument));

        StepVerifier.create(reasonService.saveReason(reasonDocument))
                .expectNext(reasonDocument)
                .verifyComplete();
    }

    @Test
    void deleteReasonTest() {
        when(reasonRepository.deleteById("1")).thenReturn(Mono.empty());

        StepVerifier.create(reasonService.deleteReason("1")).verifyComplete();
    }

    @Test
    void getAllReasonsTest() {
        ReasonDocument reasonDocument = ReasonDocument.builder()
                .baseBanDuration(10)
                .name("NAME")
                .banType(BanType.DETERMINED)
                .build();

        when(reasonRepository.findAll()).thenReturn(Flux.just(reasonDocument));

        StepVerifier.create(reasonService.getAllReasons())
                .expectNext(reasonDocument)
                .verifyComplete();
    }

    @Test
    void getReasonByNameTest() {
        ReasonDocument reasonDocument = ReasonDocument.builder()
                .baseBanDuration(10)
                .name("NAME")
                .banType(BanType.DETERMINED)
                .build();

        when(reasonRepository.findByName("NAME")).thenReturn(Mono.just(reasonDocument));

        StepVerifier.create(reasonService.getReasonByName("NAME"))
                .expectNext(reasonDocument)
                .verifyComplete();
    }
}