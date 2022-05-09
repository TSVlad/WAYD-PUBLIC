package ru.tsvlad.wayd_user.restapi.dto;

import lombok.Data;

@Data
public class UserForUpdateDTO {
    private String id;
    private String name;
    private String surname;
    private String contacts;
    private String description;
    private String avatar;
}
