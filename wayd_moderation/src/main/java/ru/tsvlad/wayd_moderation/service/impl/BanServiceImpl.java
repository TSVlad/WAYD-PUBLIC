package ru.tsvlad.wayd_moderation.service.impl;

import lombok.AllArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.common.BanCreation;
import ru.tsvlad.wayd_moderation.config.props.BanProperties;
import ru.tsvlad.wayd_moderation.document.BanDocument;
import ru.tsvlad.wayd_moderation.messaging.producer.ModerationServiceProducer;
import ru.tsvlad.wayd_moderation.repository.BanRepository;
import ru.tsvlad.wayd_moderation.restapi.controller.advice.exceptions.IncorrectBanDurationException;
import ru.tsvlad.wayd_moderation.service.BanService;
import ru.tsvlad.wayd_moderation.service.ReasonService;

import java.time.LocalDate;

@Service
@AllArgsConstructor
public class BanServiceImpl implements BanService {

    private final BanRepository banRepository;

    private final ReasonService reasonService;

    private final ModerationServiceProducer moderationServiceProducer;

    private final BanProperties banProperties;

    @Override
    public Mono<BanDocument> banUser(BanCreation banCreation) {
        return getCorrectBanCreation(banCreation).flatMap(correctBanCreation -> {
            BanDocument banDocument = BanDocument.create(correctBanCreation);
            return banRepository.save(banDocument);
        }).doOnNext(moderationServiceProducer::banUser);
    }

    private Mono<BanCreation> getCorrectBanCreation(BanCreation banCreation) {
        return reasonService.getReasonByName(banCreation.getReason())
                .flatMap(reasonDocument -> {
                    switch (reasonDocument.getBanType()) {
                        case UNDETERMINED:
                            if (banCreation.getBanDuration() == 0) {
                                return Mono.error(new IncorrectBanDurationException());
                            }
                            return Mono.just(banCreation);
                        case PERMANENT:
                            banCreation.setBanDuration(-1);
                            return Mono.just(banCreation);
                        case DETERMINED:
                            return getBanDuration(reasonDocument.getBaseBanDuration(),
                                    banCreation.getUserId()).map(duration -> {
                                banCreation.setBanDuration(duration);
                                return banCreation;
                            });
                        default:
                            return Mono.empty();
                    }
                });
    }

    private Mono<Integer> getBanDuration(int baseBanDuration, String userId) {
        return banRepository.findAllByUserId(userId)
                .count()
                .map(bansCount -> {
                    double coefficient = Math.pow(banProperties.getBanCoefficient(), bansCount);
                    return (int) Math.round(baseBanDuration * coefficient);
                });
    }

    @Scheduled(cron = "0 0 0 * * *")
    public void unBanUsers() {
        banRepository.findAllByBanUntil(LocalDate.now())
                .doOnNext(banDocument -> {
                    banRepository.findAllByUserIdAndBanUntilAfter(banDocument.getUserId(), LocalDate.now())
                            .doOnNext(System.out::println)
                            .switchIfEmpty(Mono.fromRunnable(() -> {
                                moderationServiceProducer.unbanUser(banDocument);
                            })).subscribe();
                }).subscribe();
    }
}
