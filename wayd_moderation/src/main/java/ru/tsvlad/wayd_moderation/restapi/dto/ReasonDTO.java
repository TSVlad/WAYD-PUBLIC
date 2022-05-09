package ru.tsvlad.wayd_moderation.restapi.dto;

import lombok.Data;
import ru.tsvlad.wayd_moderation.enums.BanType;

@Data
public class ReasonDTO {
    private String id;
    private String name;
    private long baseBanDuration;
    private BanType banType;
}
