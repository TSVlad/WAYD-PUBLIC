package ru.tsvlad.waydvalidator.restapi.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.tsvlad.waydvalidator.restapi.dto.BadWordDTO;
import ru.tsvlad.waydvalidator.service.BadWordService;

import java.util.List;

@RestController
@RequestMapping("/bad-words")
@AllArgsConstructor
@Slf4j
public class BadWordsController {
    private BadWordService badWordService;

    @GetMapping
    public List<BadWordDTO> getAll() {
        log.debug("Get all bad words request gotten");
        return badWordService.getAllBadWords();
    }

    @DeleteMapping("/{id}")
    public Mono<Void> deleteBadWord(@PathVariable String id) {
        log.debug("Delete bad word request gotten for id {}", id);
        return badWordService.deleteBadWordById(id);
    }

    @PostMapping()
    public Flux<BadWordDTO> addWords(@RequestBody String words) {
        log.debug("Add bad words request gotten fro words: {}", words);
        return badWordService.addAllBadWords(words);
    }
}
