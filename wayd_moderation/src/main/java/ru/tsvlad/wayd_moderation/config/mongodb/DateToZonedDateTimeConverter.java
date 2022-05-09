package ru.tsvlad.wayd_moderation.config.mongodb;

import org.springframework.core.convert.converter.Converter;
import org.springframework.data.convert.ReadingConverter;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Date;

@ReadingConverter
public class DateToZonedDateTimeConverter implements Converter<Date, ZonedDateTime> {

    @Override
    public ZonedDateTime convert(Date source) {
        return ZonedDateTime.ofInstant(source.toInstant(), ZoneId.of("UTC"));
    }
}
