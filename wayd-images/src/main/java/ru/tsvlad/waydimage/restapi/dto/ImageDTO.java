package ru.tsvlad.waydimage.restapi.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.tsvlad.waydimage.enums.ImageStatus;
import ru.tsvlad.waydimage.messaging.consumer.msg.dto.Validity;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ImageDTO {
    private String id;

    private String name;
    private String miniatureName;

    private Validity validity;
    private ImageStatus status;

    private String ownerId;
}
