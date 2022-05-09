package ru.tsvlad.waydimage.messaging.consumer.msg;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import ru.tsvlad.waydimage.messaging.AbstractMessage;
import ru.tsvlad.waydimage.messaging.consumer.msg.dto.Validity;
import ru.tsvlad.waydimage.messaging.consumer.msg.type.NeuronValidatorMessageType;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class NeuronValidatorMessage extends AbstractMessage {
    private NeuronValidatorMessageType type;
    private String imageId;
    private Validity validity;
}
