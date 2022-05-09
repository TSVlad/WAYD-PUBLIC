package ru.tsvlad.waydvalidator.messaging.producer.msg;

import lombok.*;
import lombok.experimental.SuperBuilder;
import ru.tsvlad.waydvalidator.messaging.AbstractMessage;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class ValidatorMessage extends AbstractMessage {
    private ValidatorMessageType type;
    private String eventId;
    private String userId;
    private Validity validity;
}
