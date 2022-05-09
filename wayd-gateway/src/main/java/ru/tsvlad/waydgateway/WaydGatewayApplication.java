package ru.tsvlad.waydgateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableEurekaClient
public class WaydGatewayApplication {

    public static void main(String[] args) {
        SpringApplication.run(WaydGatewayApplication.class, args);
    }

}
