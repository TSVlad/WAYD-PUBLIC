package ru.tsvlad.waydnotification;

import org.junit.ClassRule;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.KafkaContainer;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.utility.DockerImageName;

@SpringBootTest
public class BaseIntegrationTest {

    @ClassRule
    static KafkaContainer kafkaContainer = new KafkaContainer(DockerImageName.parse("confluentinc/cp-kafka:5.5.8"));
    @ClassRule
    static PostgreSQLContainer postgreSQLContainer = new PostgreSQLContainer(DockerImageName.parse("postgres:14.2"))
            .withDatabaseName("database")
            .withUsername("user")
            .withPassword("password");

    @BeforeAll
    static void init() {
        kafkaContainer.start();
        postgreSQLContainer.start();
    }

    @DynamicPropertySource
    static void kafkaProperties(DynamicPropertyRegistry props) {
        props.add("wayd.kafka.address", () -> kafkaContainer.getHost() + ":" + kafkaContainer.getFirstMappedPort());
    }

    @DynamicPropertySource
    static void postgresProperties(DynamicPropertyRegistry props) {
        props.add("spring.datasource.url", () -> "jdbc:postgresql://" + postgreSQLContainer.getHost() + ":"
                + postgreSQLContainer.getFirstMappedPort() + "/" + postgreSQLContainer.getDatabaseName());
        props.add("spring.datasource.username", () -> postgreSQLContainer.getUsername());
        props.add("spring.datasource.password", () -> postgreSQLContainer.getPassword());
    }

    @AfterAll
    static void clear() {
        kafkaContainer.stop();
        postgreSQLContainer.stop();
    }
}
