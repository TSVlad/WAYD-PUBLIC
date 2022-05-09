package ru.tsvlad.waydvalidator.document;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "badWords")
@Data
public class BadWordDocument {
    @Id
    private String id;
    private String word;

    public BadWordDocument(String word) {
        this.word = word;
    }
}
