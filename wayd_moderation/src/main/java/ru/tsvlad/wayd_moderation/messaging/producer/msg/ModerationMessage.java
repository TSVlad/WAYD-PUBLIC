package ru.tsvlad.wayd_moderation.messaging.producer.msg;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.SuperBuilder;
import ru.tsvlad.wayd_moderation.enums.ModeratorDecision;
import ru.tsvlad.wayd_moderation.messaging.AbstractMessage;
import ru.tsvlad.wayd_moderation.restapi.dto.BanDTO;

@EqualsAndHashCode(callSuper = true)
@Data
@SuperBuilder
public class ModerationMessage extends AbstractMessage {
    private ModerationMessageType type;
    private BanDTO banDTO;

    private String objectId;
    private ModeratorDecision decision;
}
