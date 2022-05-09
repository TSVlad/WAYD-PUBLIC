package com.example.waydevent.document.converter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.data.convert.WritingConverter;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;

@WritingConverter
public class ZonedDateTimeToLocalDateTimeConverter implements Converter<ZonedDateTime, LocalDateTime> {
    @Override
    public LocalDateTime convert(ZonedDateTime source) {
        return LocalDateTime.ofInstant(source.toInstant(), ZoneId.of("UTC"));
    }
}
