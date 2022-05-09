package ru.tsvlad.wayd_user.commons;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.tsvlad.wayd_user.enums.Role;
import ru.tsvlad.wayd_user.enums.UserStatus;

import java.time.LocalDate;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class User {
    private String id;
    private String username;
    private List<Role> roles;
    private String name;
    private String surname;
    private String description;
    private String contacts;
    private String email;
    private String avatar;
    private LocalDate dateOfBirth;
    private UserStatus status;
}
