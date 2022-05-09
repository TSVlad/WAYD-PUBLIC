package ru.tsvlad.waydimage.config.props;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "wayd.image")
@Data
public class ImageProperties {
    private String bucket;
    private int maxSize;
    private int smallMaxSize;
}
