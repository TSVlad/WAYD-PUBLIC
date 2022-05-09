package ru.tsvlad.wayd_moderation.service;

import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.document.SessionDocument;

public interface SessionService {
    Mono<SessionDocument> startSession(String moderatorId);
    Mono<SessionDocument> closeSession(String moderatorId);
    Mono<SessionDocument> getRandomOpenSession();
    Mono<SessionDocument> getCurrentSession(String moderatorId);
}
