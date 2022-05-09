package ru.tsvlad.waydnotification.restapi.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import ru.tsvlad.waydnotification.enums.NotificationStatus;
import ru.tsvlad.waydnotification.restapi.dto.NotificationDTO;
import ru.tsvlad.waydnotification.service.AuthenticationService;
import ru.tsvlad.waydnotification.service.NotificationService;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/notification")
@AllArgsConstructor
@Slf4j
public class NotificationController {

    private final NotificationService notificationService;
    private final AuthenticationService authenticationService;

    private final ModelMapper modelMapper;

    @GetMapping("/all/{page}/{size}")
    public Page<NotificationDTO> getAllNotifications(@PathVariable int page, @PathVariable int size,
                                                    Authentication authentication) {
        log.debug("Get all notifications request gotten for page {} and size {}", page, size);
        return notificationService.getAllNotifications(authenticationService.getUserId(authentication),
                PageRequest.of(page, size, Sort.by("timestamp").descending()))
                .map(entity -> modelMapper.map(entity, NotificationDTO.class));
    }

    @GetMapping()
    public List<NotificationDTO> getNotificationsWithStatus(
            @RequestParam(value = "status", defaultValue = "NEW, READ", required = false) List<NotificationStatus> statuses,
            Authentication authentication) {
        log.debug("Get notifications with statuses request gotten for statuses {}", statuses);
        return notificationService.getNotificationsByStatuses(
                authenticationService.getUserId(authentication), statuses).stream()
                .map(entity -> modelMapper.map(entity, NotificationDTO.class)).collect(Collectors.toList());
    }

    @PostMapping("/{id}/update-status")
    public NotificationDTO updateNotificationStatus(@PathVariable long id,
                                                    @RequestBody NotificationStatus status,
                                                    Authentication authentication) {
        log.debug("Update notifications status request gotten for notification id {} and status {}", id, status);
        return modelMapper.map(notificationService.updateStatus(id, status,
                authenticationService.getUserInfo(authentication)), NotificationDTO.class);
    }
}
