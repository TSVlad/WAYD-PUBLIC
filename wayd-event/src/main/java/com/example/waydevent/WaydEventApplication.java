package com.example.waydevent;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.kafka.annotation.EnableKafka;

@SpringBootApplication
@EnableKafka
public class WaydEventApplication {

    public static void main(String[] args) {
        SpringApplication.run(WaydEventApplication.class, args);
    }

}
