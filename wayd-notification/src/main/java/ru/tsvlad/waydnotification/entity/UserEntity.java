package ru.tsvlad.waydnotification.entity;

import lombok.*;
import org.apache.catalina.User;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "users")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserEntity {
    @Id
    @Column(name = "user_id")
    private String userId;

    @Column(name = "email")
    private String email;

    @Column(name = "send_to_email")
    private boolean sendToEmail = true;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "subscriptions",
            joinColumns = {@JoinColumn(name = "subscription_id")},
            inverseJoinColumns = {@JoinColumn(name = "subscriber_id")}
    )
    private List<UserEntity> subscribers = new ArrayList<>();

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "subscriptions",
            joinColumns = {@JoinColumn(name = "subscriber_id")},
            inverseJoinColumns = {@JoinColumn(name = "subscription_id")}
    )
    private List<UserEntity> subscriptions = new ArrayList<>();

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserEntity user = (UserEntity) o;
        return userId.equals(user.userId) && email.equals(user.email) && subscribers.equals(user.subscribers) && subscriptions.equals(user.subscriptions);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, email, subscribers, subscriptions);
    }
}
