package ru.tsvlad.wayd_moderation.service;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.document.ReasonDocument;

public interface ReasonService {
    Mono<ReasonDocument> saveReason(ReasonDocument reasonDocument);
    Mono<Void> deleteReason(String id);
    Flux<ReasonDocument> getAllReasons();
    Mono<ReasonDocument> getReasonByName(String name);
}
