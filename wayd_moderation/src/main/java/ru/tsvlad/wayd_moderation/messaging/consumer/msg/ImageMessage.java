package ru.tsvlad.wayd_moderation.messaging.consumer.msg;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import ru.tsvlad.wayd_moderation.messaging.AbstractMessage;
import ru.tsvlad.wayd_moderation.messaging.consumer.dto.ImageDTO;
import ru.tsvlad.wayd_moderation.messaging.consumer.msg.type.ImageMessageType;

@EqualsAndHashCode(callSuper = true)
@JsonIgnoreProperties(ignoreUnknown = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class ImageMessage extends AbstractMessage {
    private ImageMessageType type;
    private ImageDTO imageDTO;
    private byte[] image;
}
