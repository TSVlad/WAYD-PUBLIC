package ru.tsvlad.wayd_moderation.restapi.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Data
public class BanCreationDTO {
    @NotBlank
    @NotEmpty
    @NotNull
    private String userId;
    @NotBlank
    private String reason;
    @NotNull
    private String comment;
    private int banDuration;
}
