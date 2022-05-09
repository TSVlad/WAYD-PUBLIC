package ru.tsvlad.wayd_moderation.service.impl;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.document.ReasonDocument;
import ru.tsvlad.wayd_moderation.repository.ReasonRepository;
import ru.tsvlad.wayd_moderation.service.ReasonService;

import java.util.Locale;

@Service
@AllArgsConstructor
public class ReasonServiceImpl implements ReasonService {

    private final ReasonRepository reasonRepository;

    @Override
    public Mono<ReasonDocument> saveReason(ReasonDocument reasonDocument) {
        reasonDocument.setName(reasonDocument.getName().toUpperCase());
        return reasonRepository.save(reasonDocument);
    }

    @Override
    public Mono<Void> deleteReason(String id) {
        return reasonRepository.deleteById(id);
    }

    @Override
    public Flux<ReasonDocument> getAllReasons() {
        return reasonRepository.findAll();
    }

    @Override
    public Mono<ReasonDocument> getReasonByName(String name) {
        return reasonRepository.findByName(name);
    }
}
