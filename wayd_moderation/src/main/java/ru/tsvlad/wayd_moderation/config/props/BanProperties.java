package ru.tsvlad.wayd_moderation.config.props;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "wayd.ban")
@Data
public class BanProperties {
    float banCoefficient;
}
