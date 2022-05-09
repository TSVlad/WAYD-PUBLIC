package ru.tsvlad.waydnotification.restapi.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import ru.tsvlad.waydnotification.service.AuthenticationService;
import ru.tsvlad.waydnotification.service.SubscriptionService;

import java.util.List;

@RestController
@RequestMapping("/subscription")
@AllArgsConstructor
@Slf4j
public class SubscriptionController {

    private final SubscriptionService subscriptionService;
    private final AuthenticationService authenticationService;

    @PostMapping("/{subscriptionId}")
    public void subscribe(@PathVariable String subscriptionId, Authentication authentication) {
        log.debug("Subscribe request gotten for subscription {}", subscriptionId);
        subscriptionService.subscribe(authenticationService.getUserId(authentication), subscriptionId);
    }

    @DeleteMapping("/{subscriptionId}")
    public void cancelSubscription(@PathVariable String subscriptionId, Authentication authentication) {
        log.debug("Cancel subscription request gotten for subscription {}", subscriptionId);
        subscriptionService.cancelSubscription(authenticationService.getUserId(authentication), subscriptionId);
    }

    @GetMapping
    public List<String> getSubscriptions(Authentication authentication) {
        log.debug("Get subscriptions request gotten");
        return subscriptionService.getSubscriptionsIds(authenticationService.getUserId(authentication));
    }

    @GetMapping("/to")
    public List<String> getSubscribers(Authentication authentication) {
        log.debug("Get subscribers request gotten");
        return subscriptionService.getSubscribersIds(authenticationService.getUserId(authentication));
    }
}
