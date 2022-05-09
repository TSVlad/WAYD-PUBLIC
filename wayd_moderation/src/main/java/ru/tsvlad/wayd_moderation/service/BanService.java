package ru.tsvlad.wayd_moderation.service;

import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.common.BanCreation;
import ru.tsvlad.wayd_moderation.document.BanDocument;

public interface BanService {
    Mono<BanDocument> banUser(BanCreation banCreation);
}
