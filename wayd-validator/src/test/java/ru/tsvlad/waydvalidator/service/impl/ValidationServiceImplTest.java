package ru.tsvlad.waydvalidator.service.impl;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import ru.tsvlad.waydvalidator.BaseIntegrationTest;
import ru.tsvlad.waydvalidator.messaging.dto.EventDTO;
import ru.tsvlad.waydvalidator.messaging.dto.UserKafkaDTO;
import ru.tsvlad.waydvalidator.messaging.producer.msg.Validity;
import ru.tsvlad.waydvalidator.restapi.dto.BadWordDTO;
import ru.tsvlad.waydvalidator.service.BadWordService;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ValidationServiceImplTest extends BaseIntegrationTest {

    @Autowired
    ValidationServiceImpl validationService;

    @MockBean
    BadWordService badWordService;

    @Test
    void isValidEventValidTest() {
        EventDTO eventDTO = EventDTO.builder()
                .name("name")
                .contacts("contacts")
                .description("description")
                .build();
        List<BadWordDTO> badWordDTOS = List.of(
                BadWordDTO.builder().word("qwe").build()
        );

        Mockito.when(badWordService.getAllBadWords()).thenReturn(badWordDTOS);

        Validity result = validationService.isValidEvent(eventDTO);
        assertEquals(Validity.VALID, result);
    }

    @Test
    void isValidEventInvalidTest() {
        EventDTO eventDTO = EventDTO.builder()
                .name("name")
                .contacts("contacts")
                .description("description")
                .build();
        List<BadWordDTO> badWordDTOS = List.of(
                BadWordDTO.builder().word("description").build()
        );

        Mockito.when(badWordService.getAllBadWords()).thenReturn(badWordDTOS);

        Validity result = validationService.isValidEvent(eventDTO);
        assertEquals(Validity.NOT_VALID, result);
    }

    @Test
    void isValidUserValidTest() {
        UserKafkaDTO userKafkaDTO = UserKafkaDTO.builder()
                .name("name")
                .surname("surname")
                .description("description")
                .contacts("contacts")
                .build();

        List<BadWordDTO> badWordDTOS = List.of(
                BadWordDTO.builder().word("qwe").build()
        );

        Mockito.when(badWordService.getAllBadWords()).thenReturn(badWordDTOS);

        Validity result = validationService.isValidUser(userKafkaDTO);
        assertEquals(Validity.VALID, result);
    }

    @Test
    void isValidUserInvalidTest() {
        UserKafkaDTO userKafkaDTO = UserKafkaDTO.builder()
                .name("name")
                .surname("surname")
                .description("description")
                .contacts("contacts")
                .build();

        List<BadWordDTO> badWordDTOS = List.of(
                BadWordDTO.builder().word("description").build()
        );

        Mockito.when(badWordService.getAllBadWords()).thenReturn(badWordDTOS);

        Validity result = validationService.isValidUser(userKafkaDTO);
        assertEquals(Validity.NOT_VALID, result);
    }
}