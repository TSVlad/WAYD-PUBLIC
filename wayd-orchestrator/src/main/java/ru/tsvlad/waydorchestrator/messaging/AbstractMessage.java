package ru.tsvlad.waydorchestrator.messaging;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;
import ru.tsvlad.waydorchestrator.messaging.dto.UserInfo;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
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
