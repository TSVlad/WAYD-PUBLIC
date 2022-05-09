package ru.tsvlad.waydnotification.messaging.consumer.msg;

import lombok.*;
import ru.tsvlad.waydnotification.messaging.AbstractMessage;
import ru.tsvlad.waydnotification.messaging.consumer.msg.type.UserMessageType;
import ru.tsvlad.waydnotification.messaging.dto.ConfirmationCodeDTO;
import ru.tsvlad.waydnotification.messaging.dto.EmailCredentialsDTO;
import ru.tsvlad.waydnotification.messaging.dto.UserDTO;


@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserMessage extends AbstractMessage {
    private UserMessageType type;
    private UserDTO userDTO;
    private ConfirmationCodeDTO confirmationCodeDTO;
    private EmailCredentialsDTO emailCredentialsDTO;
}
