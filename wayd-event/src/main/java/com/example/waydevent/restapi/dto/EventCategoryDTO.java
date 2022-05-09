package com.example.waydevent.restapi.dto;

import com.example.waydevent.document.EventCategoryDocument;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EventCategoryDTO {
    private String id;

    @NotEmpty(message = "categoryName can not be empty")
    @NotNull(message = "categoryName can not be null")
    private String categoryName;
    private List<String> subCategories;

    public EventCategoryDTO(EventCategoryDocument eventCategoryDocument) {
        this.id = eventCategoryDocument.getId();
        this.categoryName = eventCategoryDocument.getCategoryName();
        this.subCategories = eventCategoryDocument.getSubCategories();
    }
}
