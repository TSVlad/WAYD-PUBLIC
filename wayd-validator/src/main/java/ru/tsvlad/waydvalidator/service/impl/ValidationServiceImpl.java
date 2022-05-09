package ru.tsvlad.waydvalidator.service.impl;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import ru.tsvlad.waydvalidator.messaging.dto.EventDTO;
import ru.tsvlad.waydvalidator.messaging.dto.UserKafkaDTO;
import ru.tsvlad.waydvalidator.messaging.producer.msg.Validity;
import ru.tsvlad.waydvalidator.restapi.dto.BadWordDTO;
import ru.tsvlad.waydvalidator.service.BadWordService;
import ru.tsvlad.waydvalidator.service.ValidationService;

import java.util.List;

@Service
@AllArgsConstructor
public class ValidationServiceImpl implements ValidationService {
    private final BadWordService badWordService;

    @Override
    public Validity isValidEvent(EventDTO eventDTO) {
        String eventString = eventToString(eventDTO);
        return validateBadWords(eventString) ? Validity.VALID : Validity.NOT_VALID;
    }

    @Override
    public Validity isValidUser(UserKafkaDTO userKafkaDTO) {
        String userString = userToString(userKafkaDTO);
        return validateBadWords(userString) ? Validity.VALID : Validity.NOT_VALID;
    }

    private String eventToString(EventDTO eventDTO) {
        return eventDTO.getName() +
                " " +
                eventDTO.getDescription() +
                " " +
                eventDTO.getContacts();
    }

    private String userToString(UserKafkaDTO userKafkaDTO) {
        return userKafkaDTO.getUsername() +
                " " +
                userKafkaDTO.getContacts() +
                " " +
                userKafkaDTO.getDescription() +
                " " +
                userKafkaDTO.getName() +
                " " +
                userKafkaDTO.getSurname();
    }

    private boolean validateBadWords(String str) {
        List<BadWordDTO> badWords = badWordService.getAllBadWords();
        String[] words = str.split(" ");
        for (String word : words) {
            for (BadWordDTO badWord : badWords) {
                if (word.hashCode() == badWord.getWord().hashCode()) {
                    if (word.equals(badWord.getWord())) {
                        return false;
                    }
                }
            }
        }
        return true;
    }
}
