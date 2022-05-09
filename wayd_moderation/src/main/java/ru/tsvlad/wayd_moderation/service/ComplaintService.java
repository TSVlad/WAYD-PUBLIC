package ru.tsvlad.wayd_moderation.service;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.common.ComplaintProcessing;
import ru.tsvlad.wayd_moderation.document.ComplaintDocument;
import ru.tsvlad.wayd_moderation.enums.ComplaintStatus;
import ru.tsvlad.wayd_moderation.enums.ComplaintType;

import java.util.List;

public interface ComplaintService {
    Mono<ComplaintDocument> createComplaintAndSetModerator(ComplaintDocument complaintDocument);
    Flux<ComplaintDocument> getComplaintsForModerator(String moderatorId, List<ComplaintStatus> complaintStatusList,
                                                      List<ComplaintType> types);
    Mono<ComplaintDocument> processComplaint(ComplaintProcessing complaintProcessing, String moderatorId);
}
