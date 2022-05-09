package ru.tsvlad.wayd_registry;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class WaydRegistryApplication {

    public static void main(String[] args) {
        SpringApplication.run(WaydRegistryApplication.class, args);
    }

}
