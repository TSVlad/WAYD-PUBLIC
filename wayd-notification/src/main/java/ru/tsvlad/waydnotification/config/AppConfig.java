package ru.tsvlad.waydnotification.config;

import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Base64;

@Configuration
public class AppConfig {

    @Bean
    public Base64.Decoder base64Decoder() {
        return Base64.getDecoder();
    }

    @Bean
    public ModelMapper modelMapper() {
        return new ModelMapper();
    }
}
