package ru.tsvlad.wayd_moderation.service.impl;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;
import ru.tsvlad.wayd_moderation.BaseIntegrationTest;
import ru.tsvlad.wayd_moderation.common.BlockType;
import ru.tsvlad.wayd_moderation.document.BlockDocument;
import ru.tsvlad.wayd_moderation.messaging.producer.ModerationServiceProducer;
import ru.tsvlad.wayd_moderation.repository.BlockRepository;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@SpringBootTest
class BlockServiceImplTest extends BaseIntegrationTest {

    @Autowired
    BlockServiceImpl blockService;

    @MockBean
    BlockRepository blockRepository;
    @MockBean
    ModerationServiceProducer moderationServiceProducer;

    @Test
    void blockEventTest() {
        BlockDocument blockDocument = BlockDocument.builder()
                .type(BlockType.EVENT)
                .comment("comment")
                .moderatorId("1")
                .reason("REASON")
                .build();
        BlockDocument blockDocumentSaved = BlockDocument.builder()
                .id("1")
                .type(BlockType.EVENT)
                .objectId("objectId")
                .comment("comment")
                .moderatorId("1")
                .reason("REASON")
                .build();
        when(blockRepository.save(blockDocument)).thenReturn(Mono.just(blockDocumentSaved));

        StepVerifier.create(blockService.block(blockDocument))
                .expectNext(blockDocumentSaved)
                .verifyComplete();

        verify(moderationServiceProducer).blockEvent(eq("objectId"));
    }

    @Test
    void blockImageTest() {
        BlockDocument blockDocument = BlockDocument.builder()
                .type(BlockType.IMAGE)
                .comment("comment")
                .moderatorId("1")
                .objectId("objectId")
                .reason("REASON")
                .build();
        BlockDocument blockDocumentSaved = BlockDocument.builder()
                .id("1")
                .objectId("objectId")
                .type(BlockType.IMAGE)
                .comment("comment")
                .moderatorId("1")
                .reason("REASON")
                .build();
        when(blockRepository.save(blockDocument)).thenReturn(Mono.just(blockDocumentSaved));

        StepVerifier.create(blockService.block(blockDocument))
                .expectNext(blockDocumentSaved)
                .verifyComplete();

        verify(moderationServiceProducer).blockImage(eq("objectId"));
    }
}