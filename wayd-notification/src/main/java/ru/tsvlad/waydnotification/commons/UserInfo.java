package ru.tsvlad.waydnotification.commons;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.tsvlad.waydnotification.config.security.Role;

import java.time.LocalDate;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserInfo {
    private String id;
    private String username;
    private List<Role> roles;
    private LocalDate dateOfBirth;
}
