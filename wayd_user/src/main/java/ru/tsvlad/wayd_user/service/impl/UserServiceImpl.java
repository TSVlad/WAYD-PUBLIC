package ru.tsvlad.wayd_user.service.impl;

import lombok.AllArgsConstructor;
import org.keycloak.representations.idm.UserRepresentation;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.tsvlad.wayd_user.commons.OrganizationRegisterInfo;
import ru.tsvlad.wayd_user.commons.User;
import ru.tsvlad.wayd_user.commons.UserRegisterInfo;
import ru.tsvlad.wayd_user.commons.UserUpdateInfo;
import ru.tsvlad.wayd_user.commons.mapper.KeycloakMapper;
import ru.tsvlad.wayd_user.enums.Role;
import ru.tsvlad.wayd_user.enums.UserAttribute;
import ru.tsvlad.wayd_user.enums.UserStatus;
import ru.tsvlad.wayd_user.enums.Validity;
import ru.tsvlad.wayd_user.messaging.dto.UserKafkaDTO;
import ru.tsvlad.wayd_user.messaging.producer.UserServiceProducer;
import ru.tsvlad.wayd_user.service.KeycloakService;
import ru.tsvlad.wayd_user.service.UserService;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {

    private UserServiceProducer userServiceProducer;

    private KeycloakService keycloakService;

    private final ModelMapper modelMapper;
    private final KeycloakMapper keycloakMapper;

    @Override
    public Page<User> getAllActiveByUsername(String username, int page, int size) {
        return keycloakService.getUsersWithUsernameLike(username, page, size).map(keycloakMapper::toUser);
    }

    @Override
    public List<User> getAllByIds(List<String> ids) {
        return keycloakService.getUsersByIds(ids).stream().map(keycloakMapper::toUser).collect(Collectors.toList());
    }

    @Override
    public User getUserById(String id) {
        return keycloakMapper.toUser(keycloakService.getUserById(id));
    }

    @Override
    public User registerUser(UserRegisterInfo userRegisterInfo) {
        UserRepresentation userRepresentation = keycloakService.addUser(userRegisterInfo);
        User result = keycloakMapper.toUser(userRepresentation);
        userServiceProducer.registerAccount(modelMapper.map(result, UserKafkaDTO.class));
        return result;
    }

    @Override
    public User registerOrganization(OrganizationRegisterInfo organizationRegisterInfo) {
        UserRepresentation userRepresentation = keycloakService.addOrganization(organizationRegisterInfo);
        User result = keycloakMapper.toUser(userRepresentation);
        return result;
    }

    @Override
    public User updateUser(UserUpdateInfo userUpdateInfo) {
        UserRepresentation userRepresentation = keycloakService.updateUser(userUpdateInfo);
        User user = keycloakMapper.toUser(userRepresentation);
        userServiceProducer.updateAccount(modelMapper.map(user, UserKafkaDTO.class));
        return user;
    }

    @Override
    public void updateValidBadWords(String id, Validity validity) {
        UserRepresentation user = keycloakService.getUserById(id);
        if (validity == Validity.VALID
                && user.getAttributes().get(UserAttribute.status).get(0).equals(UserStatus.ON_VALIDATION.name())) {
            keycloakService.updateUserStatus(id, UserStatus.ACTIVE);
        } else if (validity == Validity.NOT_VALID
                && user.getAttributes().get(UserAttribute.status).get(0).equals(UserStatus.ON_VALIDATION.name())) {
            keycloakService.updateUserStatus(id, UserStatus.INVALID_BAD_WORDS);
        }
    }

    @Override
    public void banUser(String userId) {
        keycloakService.setUserEnabled(userId, false);
    }

    @Override
    public void unbanUser(String userId) {
        keycloakService.setUserEnabled(userId, true);
    }
}
