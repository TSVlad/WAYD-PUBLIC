package ru.tsvlad.wayd_moderation.config.mongodb;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.config.EnableReactiveMongoAuditing;
import org.springframework.data.mongodb.core.convert.MongoCustomConversions;

import java.util.List;

@Configuration
@EnableReactiveMongoAuditing(dateTimeProviderRef = "customDateTimeProvider")
public class MongoDbConfig {
    @Bean
    public MongoCustomConversions customConversions(){
        return new MongoCustomConversions(List.of(new ZonedDateTimeToLocalDateTimeConverter(), new DateToZonedDateTimeConverter()));
    }
}
