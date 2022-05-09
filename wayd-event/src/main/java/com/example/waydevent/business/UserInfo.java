package com.example.waydevent.business;

import com.example.waydevent.config.security.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

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
