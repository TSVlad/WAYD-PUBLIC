package ru.tsvlad.wayd_moderation.repository;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.document.SessionDocument;

@Repository
public interface SessionRepository extends ReactiveMongoRepository<SessionDocument, String> {
    Mono<SessionDocument> findByModeratorIdAndEndIsNull(String moderatorId);
    Flux<SessionDocument> findAllByEndIsNull();
}
