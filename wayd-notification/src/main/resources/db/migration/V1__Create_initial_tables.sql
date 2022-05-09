CREATE TABLE users (
    user_id BIGINT,
    email TEXT,

    PRIMARY KEY (user_id)
);


CREATE TABLE subscriptions (
    subscriber_id BIGINT,
    subscription_id BIGINT,

    FOREIGN KEY (subscriber_id) REFERENCES users(user_id),
    FOREIGN KEY (subscription_id) REFERENCES users(user_id)
);

INSERT INTO users (user_id, email)
VALUES
       (1, 'wayd.admtest@gmail.com'),
       (2, 'wayd.moderator@yandex.ru'),
       (3, 'wayd.test@gmail.com');