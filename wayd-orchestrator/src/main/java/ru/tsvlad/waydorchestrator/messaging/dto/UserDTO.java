package ru.tsvlad.waydorchestrator.messaging.dto;

import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class UserDTO {
    private String id;
    private String username;
    private String email;
    private List<Role> roles;
    private String name;
    private String surname;
    private String description;
    private String contacts;
    private UserStatus status;
    private LocalDate dateOfBirth;
}
