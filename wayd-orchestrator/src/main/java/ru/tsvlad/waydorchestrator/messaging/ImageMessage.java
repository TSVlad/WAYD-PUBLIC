package ru.tsvlad.waydorchestrator.messaging;

import lombok.Data;
import lombok.EqualsAndHashCode;
import ru.tsvlad.waydorchestrator.messaging.dto.ImageDTO;
import ru.tsvlad.waydorchestrator.messaging.type.ImageMessageType;

@EqualsAndHashCode(callSuper = true)
@Data
public class ImageMessage extends AbstractMessage {
    private ImageMessageType type;
    private ImageDTO imageDTO;
    private byte[] image;
}
