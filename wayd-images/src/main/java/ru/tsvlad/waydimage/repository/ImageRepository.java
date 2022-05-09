package ru.tsvlad.waydimage.repository;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import org.springframework.stereotype.Repository;
import ru.tsvlad.waydimage.document.ImageDocument;

@Repository
public interface ImageRepository extends ReactiveMongoRepository<ImageDocument, String> {

}
