package com.example.waydevent.repository;

import com.example.waydevent.document.EventCategoryDocument;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;

public interface EventCategoryRepository extends ReactiveMongoRepository<EventCategoryDocument, String> {
}
