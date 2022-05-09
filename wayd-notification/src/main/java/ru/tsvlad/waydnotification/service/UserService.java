package ru.tsvlad.waydnotification.service;

import ru.tsvlad.waydnotification.entity.UserEntity;

public interface UserService {
    boolean getSendToNotificationFlag(String userId);
    void setSendToNotificationFlag(String userId, boolean flag);
    UserEntity getUserById(String id);
    UserEntity saveUser(String id, String email);
}
