package ru.tsvlad.waydnotification.service;

import ru.tsvlad.waydnotification.commons.UserInfo;
import ru.tsvlad.waydnotification.mail.EmailMessage;
import ru.tsvlad.waydnotification.messaging.dto.EmailCredentialsDTO;
import ru.tsvlad.waydnotification.messaging.dto.EventDTO;

public interface EmailGeneratorService {
    EmailMessage createNewEventCreatedEmailMessage(EventDTO eventDTO, UserInfo userInfo);
    EmailMessage createEventUpdatedEmailMessage(EventDTO eventDTO);
    EmailMessage createOrganizationRegisteredMessage(EmailCredentialsDTO emailCredentialsDTO);
}
