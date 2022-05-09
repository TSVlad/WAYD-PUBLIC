package ru.tsvlad.waydvalidator.service;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.tsvlad.waydvalidator.restapi.dto.BadWordDTO;

import java.util.List;

public interface BadWordService {
    List<BadWordDTO> getAllBadWords();
    Flux<BadWordDTO> addAllBadWords(String words);
    Mono<Void> deleteBadWordById(String id);
}
