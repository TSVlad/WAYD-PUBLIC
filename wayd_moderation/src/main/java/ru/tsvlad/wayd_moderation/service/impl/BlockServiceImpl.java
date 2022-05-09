package ru.tsvlad.wayd_moderation.service.impl;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.document.BlockDocument;
import ru.tsvlad.wayd_moderation.messaging.producer.ModerationServiceProducer;
import ru.tsvlad.wayd_moderation.repository.BlockRepository;
import ru.tsvlad.wayd_moderation.service.BlockService;

@Service
@AllArgsConstructor
public class BlockServiceImpl implements BlockService {

    private final BlockRepository blockRepository;

    private final ModerationServiceProducer moderationServiceProducer;

    @Override
    public Mono<BlockDocument> block(BlockDocument blockDocument) {
        return blockRepository.save(blockDocument)
                .doOnNext(block -> {
                    switch (block.getType()) {
                        case IMAGE:
                            moderationServiceProducer.blockImage(block.getObjectId());
                            break;
                        case EVENT:
                            moderationServiceProducer.blockEvent(block.getObjectId());
                            break;
                    }
                });
    }
}
