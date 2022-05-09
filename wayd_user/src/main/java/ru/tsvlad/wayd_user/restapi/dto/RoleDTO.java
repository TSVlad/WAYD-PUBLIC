package ru.tsvlad.wayd_user.restapi.dto;

import lombok.Data;
import ru.tsvlad.wayd_user.enums.Role;


@Data
public class RoleDTO {
    private long id;
    private Role name;
}
