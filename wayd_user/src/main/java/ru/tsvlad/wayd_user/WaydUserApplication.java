package ru.tsvlad.wayd_user;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableEurekaClient
@OpenAPIDefinition(info = @Info(
        title = "WAYD USER service API",
        description = "Service for creating, editing, searching WAYD users",
        version = "1.0.0"
))
public class WaydUserApplication {

    public static void main(String[] args) {
        SpringApplication.run(WaydUserApplication.class, args);
    }

}
