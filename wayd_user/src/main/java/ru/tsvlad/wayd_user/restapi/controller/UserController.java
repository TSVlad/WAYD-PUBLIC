package ru.tsvlad.wayd_user.restapi.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import ru.tsvlad.wayd_user.commons.OrganizationRegisterInfo;
import ru.tsvlad.wayd_user.commons.UserRegisterInfo;
import ru.tsvlad.wayd_user.commons.UserUpdateInfo;
import ru.tsvlad.wayd_user.restapi.controller.advise.exceptions.ForbiddenException;
import ru.tsvlad.wayd_user.restapi.dto.*;
import ru.tsvlad.wayd_user.service.AuthenticationService;
import ru.tsvlad.wayd_user.service.UserService;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/user")
@AllArgsConstructor
@Slf4j
public class UserController {

    private UserService userService;
    private AuthenticationService authenticationService;

    private ModelMapper modelMapper;

    @PostMapping("/register")
    @ResponseStatus(HttpStatus.CREATED)
    @Operation(
            description = "Registering user in system and sending him email for mail confirmation",
            requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    description = "Object with new user's info"
            )
    )
    public UserDTO registerUser(@RequestBody UserRegisterDTO userDTO) {
        log.debug("Register user request gotten");
        return modelMapper.map(
                userService.registerUser(modelMapper.map(userDTO, UserRegisterInfo.class)), UserDTO.class
        );
    }

    @Secured("ROLE_MODERATOR")
    @PostMapping("/register/organization")
    @Operation(
            description = "Registering organization in system and sending email for mail confirmation",
            requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    description = "Object with new organization's info"
            )
    )
    public UserDTO registerOrganization(@RequestBody OrganizationRegisterDTO organizationRegisterDTO) {
        log.debug("Register organization request gotten for {}", organizationRegisterDTO);
        return modelMapper.map(
                userService.registerOrganization(modelMapper.map(organizationRegisterDTO, OrganizationRegisterInfo.class)),
                UserDTO.class
        );
    }

    @Secured("ROLE_USER")
    @PutMapping
    @ResponseStatus(HttpStatus.ACCEPTED)
    @Operation(
            description = "Updating user info in system",
            requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    description = "Object with updated user's info"
            )
    )
    public UserDTO updateUser(@RequestBody UserForUpdateDTO userForUpdateDTO,
                              Authentication authentication) {
        log.debug("Update user request gotten: {}", userForUpdateDTO);
        String userId = authenticationService.getUserId(authentication);
        if (!userId.equals(userForUpdateDTO.getId())) {
            throw new ForbiddenException();
        }
        return modelMapper.map(
                userService.updateUser(modelMapper.map(userForUpdateDTO, UserUpdateInfo.class)),
                UserDTO.class
        );
    }

    @GetMapping
    @Operation(
            description = "Getting page with users by text",
            parameters = {
                    @Parameter(name = "searchString", description = "String to search users by name, surname, username, etc"),
                    @Parameter(name = "page", description = "Page number"),
                    @Parameter(name = "size", description = "Page size")
            }
    )
    public Page<UserPublicDTO> getAll(@RequestParam(required = false, defaultValue = "") String searchString, @RequestParam int page, @RequestParam int size) {
        log.debug("Get all users request gotten: page {}, size{}", page, size);
        return userService.getAllActiveByUsername(searchString, page, size)
                .map(user -> modelMapper.map(user, UserPublicDTO.class));
    }

    @PostMapping("/by-ids")
    @Operation(
            description = "Getting users by ids",
            requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    description = "List of users' ids"
            )
    )
    public List<UserPublicDTO> getAllByIds(@RequestBody List<String> ids) {
        log.debug("Get all users by ids request gotten: ids {}", ids);
        return userService.getAllByIds(ids).stream()
                .map(user -> modelMapper.map(user, UserPublicDTO.class))
                .collect(Collectors.toList());
    }

    @GetMapping("/{id}")
    @Operation(
            description = "Getting user by id",
            parameters = {
                    @Parameter(name = "id", description = "User's id")
            }
    )
    public UserPublicDTO getUserById(@PathVariable String id) {
        log.debug("Get user by id request gotten: id {}", id);
        return modelMapper.map(userService.getUserById(id), UserPublicDTO.class);
    }
}
