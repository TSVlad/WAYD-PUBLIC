package ru.tsvlad.wayd_moderation.service;

import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.document.BlockDocument;

public interface BlockService {
    Mono<BlockDocument> block(BlockDocument blockDocument);
}
