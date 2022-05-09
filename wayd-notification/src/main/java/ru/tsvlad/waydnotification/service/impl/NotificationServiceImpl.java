package ru.tsvlad.waydnotification.service.impl;

import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import ru.tsvlad.waydnotification.commons.UserInfo;
import ru.tsvlad.waydnotification.entity.NotificationEntity;
import ru.tsvlad.waydnotification.enums.NotificationStatus;
import ru.tsvlad.waydnotification.repository.NotificationRepository;
import ru.tsvlad.waydnotification.restapi.controller.advice.exceptions.ConflictException;
import ru.tsvlad.waydnotification.restapi.controller.advice.exceptions.ForbiddenException;
import ru.tsvlad.waydnotification.restapi.controller.advice.exceptions.NotFoundException;
import ru.tsvlad.waydnotification.service.NotificationService;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class NotificationServiceImpl implements NotificationService {

    private final NotificationRepository notificationRepository;

    @Override
    public NotificationEntity saveNotification(NotificationEntity notificationEntity) {
        return notificationRepository.save(notificationEntity);
    }

    @Override
    public List<NotificationEntity> getNotificationsByStatuses(String userId, List<NotificationStatus> statuses) {
        return notificationRepository.findAllByUserIdAndStatusIn(userId, statuses);
    }

    @Override
    public Page<NotificationEntity> getAllNotifications(String userId, Pageable pageable) {
        return notificationRepository.findAllNotificationsByUserId(userId, pageable);
    }

    @Override
    public NotificationEntity updateStatus(long id, NotificationStatus status, UserInfo userInfo) {
        Optional<NotificationEntity> notificationOptional = notificationRepository.findById(id);
        if (notificationOptional.isEmpty()) {
            throw new NotFoundException("Notification not found");
        }
        NotificationEntity notificationEntity = notificationOptional.get();
        if (!notificationEntity.getUserId().equals(userInfo.getId())) {
            throw new ForbiddenException();
        }
        if (status.ordinal() < notificationEntity.getStatus().ordinal()) {
            throw new ConflictException("Impossible to update status to lower value");
        }
        notificationEntity.setStatus(status);
        return notificationRepository.save(notificationEntity);
    }
}
