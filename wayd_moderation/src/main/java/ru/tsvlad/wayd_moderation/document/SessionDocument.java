package ru.tsvlad.wayd_moderation.document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.ZonedDateTime;

@Data
@Document(collection = "sessions")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SessionDocument {
    @Id
    private String id;

    @Indexed
    private String moderatorId;

    private ZonedDateTime start;

    @Indexed
    private ZonedDateTime end;
}
