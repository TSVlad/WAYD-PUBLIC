package ru.tsvlad.wayd_user.messaging.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ConfirmationCodeDTO {
    private long id;
    private String email;
    private String code;
    private LocalDateTime expiration;
}
