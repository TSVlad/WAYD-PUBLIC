package ru.tsvlad.wayd_moderation.messaging.consumer.dto;

import com.fasterxml.jackson.databind.jsontype.PolymorphicTypeValidator;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

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
