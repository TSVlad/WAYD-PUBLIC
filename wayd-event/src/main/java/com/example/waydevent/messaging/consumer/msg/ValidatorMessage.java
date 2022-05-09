package com.example.waydevent.messaging.consumer.msg;

import com.example.waydevent.messaging.AbstractMessage;
import com.example.waydevent.messaging.consumer.dto.Validity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class ValidatorMessage extends AbstractMessage {
    private ValidatorMessageType type;
    private String eventId;
    private String userId;
    private Validity validity;
}
