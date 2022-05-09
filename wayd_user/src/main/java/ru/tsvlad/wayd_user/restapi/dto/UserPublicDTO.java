package ru.tsvlad.wayd_user.restapi.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import ru.tsvlad.wayd_user.enums.Role;

import java.time.LocalDate;
import java.util.List;

@Data
public class UserPublicDTO {
    private String id;
    private String username;
    private List<Role> roles;
    private String name;
    private String surname;
    private String description;
    private String contacts;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dateOfBirth;
    private String avatar;
}
