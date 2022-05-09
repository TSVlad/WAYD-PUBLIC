package ru.tsvlad.waydnotification.mail;

import javax.mail.MessagingException;

public interface EmailService {
    void send(EmailMessage emailMessage);
}
