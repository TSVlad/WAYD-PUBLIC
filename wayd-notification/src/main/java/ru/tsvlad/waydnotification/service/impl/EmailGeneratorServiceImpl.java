package ru.tsvlad.waydnotification.service.impl;

import org.springframework.stereotype.Service;
import ru.tsvlad.waydnotification.commons.UserInfo;
import ru.tsvlad.waydnotification.mail.EmailMessage;
import ru.tsvlad.waydnotification.messaging.dto.EmailCredentialsDTO;
import ru.tsvlad.waydnotification.messaging.dto.EventDTO;
import ru.tsvlad.waydnotification.service.EmailGeneratorService;

import java.util.HashMap;
import java.util.Map;

@Service
public class EmailGeneratorServiceImpl implements EmailGeneratorService {

    @Override
    public EmailMessage createNewEventCreatedEmailMessage(EventDTO eventDTO, UserInfo userInfo) {
        Map<String, Object> context = new HashMap<>();
        context.put("event", eventDTO);
        context.put("creatorName", userInfo.getUsername());

        return EmailMessage.builder()
                .templateLocation("new_event_created_template.html")
                .subject("New event form user you subscribed")
                .context(context)
                .build();
    }

    @Override
    public EmailMessage createEventUpdatedEmailMessage(EventDTO eventDTO) {
        Map<String, Object> context = new HashMap<>();
        context.put("event", eventDTO);

        return EmailMessage.builder()
                .templateLocation("event_updated_template.html")
                .subject("Event was updated")
                .context(context)
                .build();
    }

    @Override
    public EmailMessage createOrganizationRegisteredMessage(EmailCredentialsDTO emailCredentialsDTO) {
        Map<String, Object> context = new HashMap<>();
        context.put("password", emailCredentialsDTO.getPassword());
        context.put("username", emailCredentialsDTO.getUsername());

        return EmailMessage.builder()
                .to(emailCredentialsDTO.getEmail())
                .templateLocation("organization_registered_template.html")
                .subject("Account was registered")
                .context(context)
                .build();
    }
}
