package ru.tsvlad.waydimage.restapi.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ImageNamesDTO {
    private String fullName;
    private String smallName;
}
