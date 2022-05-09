package com.example.waydevent.repository;

import com.example.waydevent.document.EventDocument;
import org.springframework.data.mongodb.core.geo.GeoJsonPolygon;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;

import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.List;

@Repository
public interface EventRepository extends ReactiveMongoRepository<EventDocument, String> {

    Flux<EventDocument> findAllByPointWithinAndDateTimeAfter(GeoJsonPolygon geoJsonPolygon, ZonedDateTime dateTime);

    Flux<EventDocument> findAllByOwnerId(String id);

    Flux<EventDocument> findAllByIdIn(List<String> ids);

    Flux<EventDocument> findAllByParticipantsIdsContaining(String id);
}
