package ru.tsvlad.waydorchestrator.messaging.dto;

import lombok.Data;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;

import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Data
public class EventDTO {
    private String id;
    private long version;

    private String name;
    private String description;
    private String contacts;
    private String category;
    private String subCategory;
    private ZonedDateTime dateTime;
    private int minNumberOfParticipants;
    private int maxNumberOfParticipants;
    private ZonedDateTime deadline;
    private List<String> picturesRefs = new ArrayList<>();
    private GeoJsonPoint point;
    private int minAge;
    private int maxAge;

    private Validity validity;
    private EventStatus status;
    private EventType type;

    private String ownerId;
    private List<Long> participantsIds = new ArrayList<>();
    private Map<Long, Integer> rates = new HashMap<>();
}
