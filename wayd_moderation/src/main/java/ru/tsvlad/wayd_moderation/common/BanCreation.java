package ru.tsvlad.wayd_moderation.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BanCreation {
    private String userId;
    private String reason;
    private String comment;
    private int banDuration;
    private String moderatorId;
}
