package ru.tsvlad.wayd_user.restapi.dto;

import lombok.Data;

@Data
public class ConfirmationCodeDTO {
    private String email;
    private String code;
}
