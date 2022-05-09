package ru.tsvlad.waydnotification.messaging.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import ru.tsvlad.waydnotification.config.security.Role;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class UserDTO {
    private String id;
    private String username;
    private List<Role> roles;
    private String contacts;
    private String email;
}
