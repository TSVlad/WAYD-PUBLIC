package ru.tsvlad.waydimage.messaging.producer.msg;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.SuperBuilder;
import ru.tsvlad.waydimage.messaging.AbstractMessage;
import ru.tsvlad.waydimage.restapi.dto.ImageDTO;

@EqualsAndHashCode(callSuper = true)
@Data
@SuperBuilder
public class ImageMessage extends AbstractMessage {
    private ImageMessageType type;
    private ImageDTO imageDTO;
    private byte[] image;
}
