package ru.tsvlad.waydnotification.mail;

import lombok.Builder;
import lombok.Data;

import java.util.Map;

@Data
@Builder
public class EmailMessage {
    private String from;
    private String to;
    private String subject;
    private String templateLocation;
    private Map<String, Object> context;
}
