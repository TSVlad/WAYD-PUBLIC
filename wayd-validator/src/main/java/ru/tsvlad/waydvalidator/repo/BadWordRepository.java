package ru.tsvlad.waydvalidator.repo;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import org.springframework.stereotype.Repository;
import ru.tsvlad.waydvalidator.document.BadWordDocument;

@Repository
public interface BadWordRepository extends ReactiveMongoRepository<BadWordDocument, String> {
}
