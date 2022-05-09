package ru.tsvlad.wayd_user;

import org.junit.ClassRule;
import org.junit.jupiter.api.BeforeAll;
import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.KafkaContainer;
import org.testcontainers.utility.DockerImageName;
import ru.tsvlad.wayd_user.config.props.KeycloakProperties;

@SpringBootTest
public class BaseIntegrationTest {
    @MockBean
    protected Keycloak keycloak;
    @MockBean
    protected KeycloakProperties keycloakProperties;
    @Autowired
    protected TestsUtils testsUtils;

    @ClassRule
    static KafkaContainer kafkaContainer = new KafkaContainer(DockerImageName.parse("confluentinc/cp-kafka:5.5.8"));

    @BeforeAll
    static void init() {
        kafkaContainer.start();
    }

    @DynamicPropertySource
    static void kafkaProperties(DynamicPropertyRegistry props) {
        props.add("wayd.kafka.address", () -> kafkaContainer.getHost() + ":" + kafkaContainer.getFirstMappedPort());
    }
}
