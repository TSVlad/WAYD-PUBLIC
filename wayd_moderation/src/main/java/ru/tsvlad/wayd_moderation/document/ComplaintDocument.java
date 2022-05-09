package ru.tsvlad.wayd_moderation.document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Version;
import org.springframework.data.mongodb.core.mapping.Document;
import ru.tsvlad.wayd_moderation.common.ComplaintProcessing;
import ru.tsvlad.wayd_moderation.enums.ComplaintStatus;
import ru.tsvlad.wayd_moderation.enums.ComplaintType;
import ru.tsvlad.wayd_moderation.messaging.consumer.dto.ImageDTO;
import ru.tsvlad.wayd_moderation.restapi.dto.EventDTO;
import ru.tsvlad.wayd_moderation.restapi.dto.UserDTO;

import java.time.ZonedDateTime;

@Data
@Document(collection = "complaints")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ComplaintDocument {
    @Id
    private String id;
    @Version
    private long version;

    @CreatedDate
    private ZonedDateTime created;
    private ZonedDateTime processed;

    private String topic;
    private String message;
    private String reason;

    private String complainingUserId;

    private String objectId;

    private ComplaintType type;

    private String moderatorId;
    private String moderatorComment;

    private ComplaintStatus complaintStatus = ComplaintStatus.NEW;

    public void process(ComplaintProcessing complaintProcessing) {
        this.complaintStatus = complaintProcessing.getComplaintStatus();
        this.moderatorComment = complaintProcessing.getModeratorComment();
        this.processed = ZonedDateTime.now();
    }

    public static ComplaintDocument createInvalidImageComplaint(ImageDTO imageDTO) {
        return ComplaintDocument.builder()
                .objectId(imageDTO.getId())
                .type(ComplaintType.INVALID_IMAGE)
                .complaintStatus(ComplaintStatus.NEW)
                .build();
    }
}
