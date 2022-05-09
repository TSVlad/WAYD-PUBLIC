package com.example.waydevent.restapi.dto;

import lombok.Data;
import org.springframework.data.mongodb.core.geo.GeoJsonPolygon;

import java.time.ZonedDateTime;

@Data
public class EventFilterDTO {
    String category;
    String subcategory;
    ZonedDateTime dateAfter;
    ZonedDateTime dateBefore;

    GeoJsonPolygon geoJsonPolygon;
}
