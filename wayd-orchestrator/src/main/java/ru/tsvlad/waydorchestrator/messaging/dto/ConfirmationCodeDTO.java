package ru.tsvlad.waydorchestrator.messaging.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ConfirmationCodeDTO {
    private String id;
    private String email;
    private String code;
    private LocalDateTime expiration;
}
