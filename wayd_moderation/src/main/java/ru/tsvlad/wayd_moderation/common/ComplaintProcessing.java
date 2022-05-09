package ru.tsvlad.wayd_moderation.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.tsvlad.wayd_moderation.enums.ModeratorDecision;
import ru.tsvlad.wayd_moderation.enums.ComplaintStatus;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ComplaintProcessing {
    private String complaintId;
    private String moderatorComment;

    private ComplaintStatus complaintStatus;
}
