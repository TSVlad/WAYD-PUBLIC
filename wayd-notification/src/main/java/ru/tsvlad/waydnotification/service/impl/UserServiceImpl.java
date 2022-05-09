package ru.tsvlad.waydnotification.service.impl;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.tsvlad.waydnotification.entity.UserEntity;
import ru.tsvlad.waydnotification.repository.UserRepository;
import ru.tsvlad.waydnotification.restapi.controller.advice.exceptions.NotFoundException;
import ru.tsvlad.waydnotification.service.UserService;

import java.util.Optional;

@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;


    @Override
    @Transactional
    public boolean getSendToNotificationFlag(String userId) {
        return getUserById(userId).isSendToEmail();
    }

    @Override
    @Transactional
    public void setSendToNotificationFlag(String userId, boolean flag) {
        UserEntity user = getUserById(userId);
        user.setSendToEmail(flag);
        userRepository.save(user);
    }

    @Override
    @Transactional
    public UserEntity getUserById(String id) {
        Optional<UserEntity> userOptional = userRepository.findById(id);
        if ( userOptional.isEmpty()) {
            throw new NotFoundException();
        }
        return userOptional.get();
    }

    @Override
    public UserEntity saveUser(String id, String email) {
        UserEntity entity = new UserEntity();
        entity.setUserId(id);
        entity.setEmail(email);
        return userRepository.save(entity);
    }
}
