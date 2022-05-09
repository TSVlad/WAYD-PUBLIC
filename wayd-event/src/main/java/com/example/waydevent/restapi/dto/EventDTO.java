package com.example.waydevent.restapi.dto;

import com.example.waydevent.enums.EventStatus;
import com.example.waydevent.enums.EventType;
import com.example.waydevent.messaging.consumer.dto.Validity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;

import java.time.ZonedDateTime;
import java.util.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
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
    private Set<String> participantsIds = new HashSet<>();
    private Map<String, Integer> rates = new HashMap<>();
}
