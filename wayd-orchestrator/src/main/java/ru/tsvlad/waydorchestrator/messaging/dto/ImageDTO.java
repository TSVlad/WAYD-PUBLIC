package ru.tsvlad.waydorchestrator.messaging.dto;

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
