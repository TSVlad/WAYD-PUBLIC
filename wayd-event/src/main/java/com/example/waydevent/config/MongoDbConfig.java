package com.example.waydevent.config;

import com.example.waydevent.document.converter.DateToZonedDateTimeConverter;
import com.example.waydevent.document.converter.ZonedDateTimeToLocalDateTimeConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.convert.MongoCustomConversions;

import java.util.List;

@Configuration
public class MongoDbConfig {
    @Bean
    public MongoCustomConversions customConversions(){
//        List<Converter<?,?>> converters = new ArrayList<>();
//        converters.add(new ZonedDateTimeToLocalDateTimeConverter());
//        converters.add(new LocalDateTimeToZonedDateTimeConverter());
//        return new CustomConversions(CustomConversions.StoreConversions.NONE, converters);
        return new MongoCustomConversions(List.of(new ZonedDateTimeToLocalDateTimeConverter(), new DateToZonedDateTimeConverter()));
    }
}
