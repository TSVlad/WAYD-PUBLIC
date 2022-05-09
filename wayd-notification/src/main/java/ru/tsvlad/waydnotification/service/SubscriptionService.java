package ru.tsvlad.waydnotification.service;

import ru.tsvlad.waydnotification.entity.UserEntity;

import java.util.List;

public interface SubscriptionService {
    void subscribe(String subscriberId, String subscriptionId);
    void cancelSubscription(String subscriberId, String subscriptionId);
    List<UserEntity> getSubscriptions(String userId);
    List<String> getSubscriptionsIds(String userId);
    List<UserEntity> getSubscribers(String userId);
    List<String> getSubscribersIds(String userId);
    List<UserEntity> getUsersByIds(List<String> users);
}
