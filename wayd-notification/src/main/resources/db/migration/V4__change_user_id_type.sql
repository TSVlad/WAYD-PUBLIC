DROP TABLE notifications;
DROP TABLE subscriptions;
DROP TABLE users;

CREATE TABLE users (
                       user_id TEXT,
                       email TEXT,
                       send_to_email BOOLEAN DEFAULT true NOT NULL,

                       PRIMARY KEY (user_id)
);


CREATE TABLE subscriptions (
                               subscriber_id TEXT,
                               subscription_id TEXT,

                               FOREIGN KEY (subscriber_id) REFERENCES users(user_id),
                               FOREIGN KEY (subscription_id) REFERENCES users(user_id)
);

INSERT INTO users (user_id, email)
VALUES
    ('c67454de-5385-4c80-93a6-11a95242ceff', 'wayd.admtest@gmail.com'),
    ('5b4ceba7-52e3-47c3-a41c-8c17b0b522a0', 'wayd.moderator@yandex.ru'),
    ('d6512e1f-144c-40e1-9a7b-3b1a69207cbf', 'wayd.test@gmail.com');

CREATE TABLE notifications (
                               id BIGSERIAL NOT NULL,

                               user_id TEXT NOT NULL,

                               subject TEXT NOT NULL,
                               body TEXT NOT NULL,

                               timestamp TIMESTAMPTZ,

                               status TEXT NOT NULL,

                               PRIMARY KEY (id),
                               FOREIGN KEY (user_id) REFERENCES users(user_id)

);

CREATE INDEX ON notifications (user_id, status);