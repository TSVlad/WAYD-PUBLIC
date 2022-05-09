package ru.tsvlad.wayd_moderation.config.mongodb;

import org.springframework.data.auditing.DateTimeProvider;
import org.springframework.stereotype.Component;

import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAccessor;
import java.util.Optional;

@Component("customDateTimeProvider")
public class CustomDateTimeProvider implements DateTimeProvider {
    @Override
    public Optional<TemporalAccessor> getNow() {
        return Optional.of(ZonedDateTime.now().truncatedTo(ChronoUnit.MILLIS));
    }
}
