package ru.tsvlad.wayd_user.messaging.dto;

import lombok.Data;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;

import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
public class EventDTO {
    private String id;

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

    private String ownerId;
    private List<Long> participantsIds = new ArrayList<>();
}
