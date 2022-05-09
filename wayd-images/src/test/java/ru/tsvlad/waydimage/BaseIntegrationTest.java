package ru.tsvlad.waydimage;

import org.junit.ClassRule;
import org.junit.jupiter.api.BeforeAll;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.KafkaContainer;
import org.testcontainers.containers.MongoDBContainer;
import org.testcontainers.utility.DockerImageName;

@SpringBootTest
public class BaseIntegrationTest {

    @ClassRule
    static KafkaContainer kafkaContainer = new KafkaContainer(DockerImageName.parse("confluentinc/cp-kafka:5.5.8"));
    @ClassRule
    static MongoDBContainer mongoDBContainer = new MongoDBContainer(DockerImageName.parse("mongo:5.0.6"));

    @BeforeAll
    static void init() {
        kafkaContainer.start();
        mongoDBContainer.start();
    }

    @DynamicPropertySource
    static void kafkaProperties(DynamicPropertyRegistry props) {
        props.add("wayd.kafka.address", () -> kafkaContainer.getHost() + ":"
                + kafkaContainer.getFirstMappedPort());
    }

    @DynamicPropertySource
    static void mongoDbProperties(DynamicPropertyRegistry props) {
        props.add("spring.data.mongodb.uri", () -> "mongodb://" + mongoDBContainer.getHost() + ":"
                + mongoDBContainer.getFirstMappedPort() + "/testdb");
    }

}
