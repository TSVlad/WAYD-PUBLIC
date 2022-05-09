package ru.tsvlad.wayd_moderation.repository;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.document.ReasonDocument;

public interface ReasonRepository extends ReactiveMongoRepository<ReasonDocument, String> {
    Mono<ReasonDocument> findByName(String name);
}
