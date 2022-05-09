CREATE TABLE notifications (
    id BIGSERIAL NOT NULL,

    user_id BIGINT NOT NULL,

    subject TEXT NOT NULL,
    body TEXT NOT NULL,

    timestamp TIMESTAMPTZ,

    status TEXT NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)

);

CREATE INDEX ON notifications (user_id, status);