package ru.tsvlad.wayd_moderation.document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;
import ru.tsvlad.wayd_moderation.common.BlockType;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Document(collection = "blocks")
public class BlockDocument {
    private String id;
    private BlockType type;
    private String reason;
    private String comment;
    private String objectId;
    private String moderatorId;
}
