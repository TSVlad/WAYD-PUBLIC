package ru.tsvlad.waydnotification.messaging;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;
import lombok.experimental.SuperBuilder;
import ru.tsvlad.waydnotification.commons.UserInfo;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@SuperBuilder
public abstract class AbstractMessage implements Serializable {
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Long id;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss.SSS")
    private LocalDateTime created;

    private UserInfo userInfo;

    public AbstractMessage() {
        this.created = LocalDateTime.now();
    }
}
