package ru.tsvlad.waydorchestrator.messaging;

import lombok.Data;
import lombok.EqualsAndHashCode;
import ru.tsvlad.waydorchestrator.messaging.dto.Validity;
import ru.tsvlad.waydorchestrator.messaging.type.NeuronValidatorMessageType;

@EqualsAndHashCode(callSuper = true)
@Data
public class NeuronValidatorMessage extends AbstractMessage {
    private NeuronValidatorMessageType type;
    private String imageId;
    private Validity validity;
}
