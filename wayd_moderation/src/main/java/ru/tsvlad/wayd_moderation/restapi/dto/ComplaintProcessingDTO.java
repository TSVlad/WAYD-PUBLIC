package ru.tsvlad.wayd_moderation.restapi.dto;

import lombok.Data;
import ru.tsvlad.wayd_moderation.enums.ComplaintStatus;
import ru.tsvlad.wayd_moderation.enums.ModeratorDecision;

@Data
public class ComplaintProcessingDTO {
    private String complaintId;
    private ComplaintStatus complaintStatus;
    private String moderatorComment;

    private ModeratorDecision moderatorDecision;
    private BanCreationDTO banCreation;
}
