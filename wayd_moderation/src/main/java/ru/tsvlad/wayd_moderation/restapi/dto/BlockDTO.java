package ru.tsvlad.wayd_moderation.restapi.dto;

import lombok.Data;
import ru.tsvlad.wayd_moderation.common.BlockType;

@Data
public class BlockDTO {
    private String id;
    private BlockType type;
    private String reason;
    private String comment;
    private String objectId;
    private String moderatorId;
}
