package ru.tsvlad.waydorchestrator.messaging.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmailCredentialsDTO {
    private String userId;
    private String email;
    private String username;
    private String password;
}
