package ru.tsvlad.wayd_moderation.repository;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import ru.tsvlad.wayd_moderation.document.ComplaintDocument;
import ru.tsvlad.wayd_moderation.enums.ComplaintStatus;
import ru.tsvlad.wayd_moderation.enums.ComplaintType;

import java.util.List;

@Repository
public interface ComplaintRepository extends ReactiveMongoRepository<ComplaintDocument, String> {
    Flux<ComplaintDocument> findByModeratorIdAndComplaintStatusInAndTypeIn(String moderatorId,
                                                                           List<ComplaintStatus> complaintStatusList,
                                                                           List<ComplaintType> types);
    Flux<ComplaintDocument> findAllByModeratorIdIsNull();
}
