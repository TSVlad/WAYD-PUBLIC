package ru.tsvlad.waydnotification.service.impl;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.tsvlad.waydnotification.entity.UserEntity;
import ru.tsvlad.waydnotification.repository.UserRepository;
import ru.tsvlad.waydnotification.service.SubscriptionService;
import ru.tsvlad.waydnotification.service.UserService;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class SubscriptionServiceImpl implements SubscriptionService {

    private final UserRepository userRepository;

    private final UserService userService;

    @Override
    @Transactional
    public void subscribe(String subscriberId, String subscriptionId) {
        UserEntity subscriber = userService.getUserById(subscriberId);
        UserEntity subscription =  userService.getUserById(subscriptionId);

        subscriber.getSubscriptions().add(subscription);
        userRepository.save(subscriber);
    }

    @Override
    @Transactional
    public void cancelSubscription(String subscriberId, String subscriptionId) {
        UserEntity subscriber = userService.getUserById(subscriberId);
        UserEntity subscription =  userService.getUserById(subscriptionId);

        subscriber.getSubscriptions().remove(subscription);
        userRepository.save(subscriber);
    }

    @Override
    @Transactional
    public List<String> getSubscriptionsIds(String userId) {
        return getSubscriptions(userId).stream().map(UserEntity::getUserId).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public List<UserEntity> getSubscriptions(String userId) {
        return userService.getUserById(userId).getSubscriptions();
    }

    @Override
    @Transactional
    public List<String> getSubscribersIds(String userId) {
        return getSubscribers(userId).stream().map(UserEntity::getUserId).collect(Collectors.toList());
    }

    @Override
    public List<UserEntity> getUsersByIds(List<String> ids) {
        return userRepository.findAllByUserIdIn(ids);
    }

    @Override
    @Transactional
    public List<UserEntity> getSubscribers(String userId) {
        return userService.getUserById(userId).getSubscribers();
    }
}
