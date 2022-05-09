package ru.tsvlad.wayd_moderation.repository;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import org.springframework.stereotype.Repository;
import ru.tsvlad.wayd_moderation.document.BlockDocument;

@Repository
public interface BlockRepository extends ReactiveMongoRepository<BlockDocument, String> {

}
