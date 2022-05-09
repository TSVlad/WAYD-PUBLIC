package ru.tsvlad.waydimage.config;

import io.minio.MinioClient;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import ru.tsvlad.waydimage.config.props.MinioProperties;

@Configuration
@RequiredArgsConstructor
public class AppConfig {
    private final MinioProperties minioProperties;


    @Bean
    MinioClient minioClient() {
        return MinioClient.builder()
                .endpoint(minioProperties.getHost())
                .credentials(minioProperties.getUsername(), minioProperties.getPassword())
                .build();
    }

    @Bean
    ModelMapper modelMapper() {
        return new ModelMapper();
    }
}
