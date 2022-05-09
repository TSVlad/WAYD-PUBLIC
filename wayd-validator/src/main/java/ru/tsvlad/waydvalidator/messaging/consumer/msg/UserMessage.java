package ru.tsvlad.waydvalidator.messaging.consumer.msg;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;
import ru.tsvlad.waydvalidator.messaging.AbstractMessage;
import ru.tsvlad.waydvalidator.messaging.consumer.msg.type.UserMessageType;
import ru.tsvlad.waydvalidator.messaging.dto.UserKafkaDTO;


@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@JsonIgnoreProperties(ignoreUnknown = true)
public class UserMessage extends AbstractMessage {
    private UserMessageType type;
    private UserKafkaDTO userDTO;
}
