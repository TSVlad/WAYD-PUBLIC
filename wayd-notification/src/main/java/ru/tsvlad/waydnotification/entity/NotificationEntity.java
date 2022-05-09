package ru.tsvlad.waydnotification.entity;

import lombok.*;
import ru.tsvlad.waydnotification.enums.NotificationStatus;

import javax.persistence.*;
import java.time.ZonedDateTime;
import java.util.Objects;

@Entity
@Table(name = "notifications")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;

    @Column(name = "user_id")
    private String userId;

    @Column(name = "subject")
    private String subject;
    @Column(name = "body")
    private String body;
    @Column(name = "timestamp")
    private ZonedDateTime timestamp;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private NotificationStatus status;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        NotificationEntity that = (NotificationEntity) o;
        return id == that.id && userId.equals(that.userId) && Objects.equals(subject, that.subject) && Objects.equals(body, that.body) && timestamp.equals(that.timestamp) && status == that.status;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, userId, subject, body, timestamp, status);
    }
}
