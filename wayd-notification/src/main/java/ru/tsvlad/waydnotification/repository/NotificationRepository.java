package ru.tsvlad.waydnotification.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import ru.tsvlad.waydnotification.entity.NotificationEntity;
import ru.tsvlad.waydnotification.enums.NotificationStatus;

import java.util.List;

public interface NotificationRepository extends PagingAndSortingRepository<NotificationEntity, Long> {
    List<NotificationEntity> findAllByUserIdAndStatusIn(String userId, List<NotificationStatus> status);
    Page<NotificationEntity> findAllNotificationsByUserId(String userId, Pageable pageable);
}
