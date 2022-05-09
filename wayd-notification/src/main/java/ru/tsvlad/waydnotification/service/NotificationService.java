package ru.tsvlad.waydnotification.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import ru.tsvlad.waydnotification.commons.UserInfo;
import ru.tsvlad.waydnotification.entity.NotificationEntity;
import ru.tsvlad.waydnotification.enums.NotificationStatus;

import java.util.List;

public interface NotificationService {
    NotificationEntity saveNotification(NotificationEntity notificationEntity);
    List<NotificationEntity> getNotificationsByStatuses(String userId, List<NotificationStatus> status);
    Page<NotificationEntity> getAllNotifications(String userId, Pageable pageable);
    NotificationEntity updateStatus(long id, NotificationStatus status, UserInfo userInfo);
}
