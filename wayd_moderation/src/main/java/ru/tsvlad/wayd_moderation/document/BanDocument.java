package ru.tsvlad.wayd_moderation.document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import ru.tsvlad.wayd_moderation.common.BanCreation;

import java.time.LocalDate;
import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;

@Data
@Document(collection = "bans")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BanDocument {
    @Id
    private String id;

    private String userId;
    private String reason;
    private String comment;
    @CreatedDate
    private ZonedDateTime banDateTime;
    private LocalDate banUntil;

    private String moderatorId;

    public static BanDocument create(BanCreation banCreation) {
        return BanDocument.builder()
                .userId(banCreation.getUserId())
                .reason(banCreation.getReason())
                .comment(banCreation.getComment())
                .banUntil(banCreation.getBanDuration() >= 0 ?
                        LocalDate.now().plus(banCreation.getBanDuration(), ChronoUnit.DAYS)
                        : null)
                .moderatorId(banCreation.getModeratorId())
                .build();
    }
}
