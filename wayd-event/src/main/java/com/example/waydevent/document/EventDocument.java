package com.example.waydevent.document;

import com.example.waydevent.business.UserInfo;
import com.example.waydevent.config.security.Role;
import com.example.waydevent.enums.EventStatus;
import com.example.waydevent.enums.EventType;
import com.example.waydevent.messaging.consumer.dto.Validity;
import com.example.waydevent.restapi.controller.advice.exceptions.InvalidAgeException;
import com.example.waydevent.restapi.controller.advice.exceptions.TooManyParticipantsException;
import com.example.waydevent.restapi.dto.EventForCreateAndUpdateDTO;
import com.example.waydevent.util.MappingUtils;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Version;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Document(collection = "events")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EventDocument {
    @Id
    private String id;
    @Version
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

    private EventType type;
    private Validity validity;
    private EventStatus status;

    private String ownerId;
    private Set<String> participantsIds = new HashSet<>();

    private Map<String, Integer> rates = new HashMap<>();

    public static EventDocument createEvent(EventForCreateAndUpdateDTO eventForCreateAndUpdateDTO, UserInfo userInfo) {
        EventDocument eventDocument = MappingUtils.map(eventForCreateAndUpdateDTO, EventDocument.class);
        eventDocument.setStatus(EventStatus.ON_VALIDATION);
        eventDocument.setValidity(Validity.NOT_VALIDATED);
        eventDocument.setOwnerId(userInfo.getId());

        if (userInfo.getRoles().contains(Role.ROLE_ORGANIZATION)) {
            eventDocument.setType(EventType.ORGANIZATIONAL);
        } else {
            eventDocument.setType(EventType.PERSONAL);
        }

        return eventDocument;
    }

    public void updateEvent(EventForCreateAndUpdateDTO eventForCreateAndUpdateDTO) {
        this.name = eventForCreateAndUpdateDTO.getName();
        this.description = eventForCreateAndUpdateDTO.getDescription();
        this.contacts = eventForCreateAndUpdateDTO.getContacts();
        this.category = eventForCreateAndUpdateDTO.getCategory();
        this.subCategory = eventForCreateAndUpdateDTO.getSubCategory();
        this.dateTime = eventForCreateAndUpdateDTO.getDateTime();
        this.minNumberOfParticipants = eventForCreateAndUpdateDTO.getMinNumberOfParticipants();
        this.maxNumberOfParticipants = eventForCreateAndUpdateDTO.getMaxNumberOfParticipants();
        this.minAge = eventForCreateAndUpdateDTO.getMinAge();
        this.maxAge = eventForCreateAndUpdateDTO.getMaxAge();
        this.deadline = eventForCreateAndUpdateDTO.getDeadline();
        this.picturesRefs = eventForCreateAndUpdateDTO.getPicturesRefs();
        this.point = eventForCreateAndUpdateDTO.getPoint();

        this.validity = Validity.NOT_VALIDATED;
        this.status = EventStatus.ON_VALIDATION;
    }

    public void updateValidity(Validity validity) {
        this.validity = validity;
        switch (validity) {
            case VALID:
                this.status = EventStatus.ACTIVE;
                break;
            case NOT_VALID:
                this.status = EventStatus.INVALID;
        }
    }

    public void addParticipant(UserInfo userInfo) {
        if (this.minAge != 0 && userInfo.getDateOfBirth().isAfter(this.dateTime.toLocalDate().minus(this.minAge, ChronoUnit.YEARS))
                || this.maxAge != 0 && userInfo.getDateOfBirth().isBefore(this.dateTime.toLocalDate().minus(this.maxAge, ChronoUnit.YEARS))) {
            throw new InvalidAgeException();
        }

        if (this.maxNumberOfParticipants != 0 && this.participantsIds.size() >= this.maxNumberOfParticipants) {
            throw new TooManyParticipantsException();
        }

        this.participantsIds.add(userInfo.getId());
    }

    public  void cancelParticipation(String participantId) {
        this.participantsIds.remove(participantId);
    }

    public void block() {
        this.status = EventStatus.BLOCKED_BY_MODERATOR;
    }
}
