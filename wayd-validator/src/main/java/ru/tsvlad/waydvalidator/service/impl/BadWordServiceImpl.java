package ru.tsvlad.waydvalidator.service.impl;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.tsvlad.waydvalidator.document.BadWordDocument;
import ru.tsvlad.waydvalidator.repo.BadWordRepository;
import ru.tsvlad.waydvalidator.restapi.dto.BadWordDTO;
import ru.tsvlad.waydvalidator.service.BadWordService;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Service
public class BadWordServiceImpl implements BadWordService {

    private final BadWordRepository badWordRepository;
    private final ModelMapper modelMapper;
    private final Map<String, BadWordDocument> badWordsMap;

    public BadWordServiceImpl(BadWordRepository badWordRepository, ModelMapper modelMapper) {
        this.badWordRepository = badWordRepository;
        this.modelMapper = modelMapper;

        this.badWordsMap = new ConcurrentHashMap<>();
        this.badWordRepository.findAll()
                .doOnNext(badWord -> badWordsMap.put(badWord.getId(), badWord))
                .subscribe();
    }

    @Override
    public List<BadWordDTO> getAllBadWords() {
        return badWordsMap.values().stream().map(document -> modelMapper.map(document, BadWordDTO.class)).collect(Collectors.toList());
    }

    @Override
    public Flux<BadWordDTO> addAllBadWords(String words) {
        List<String> wordsList = List.of(words.split(" "));
        return badWordRepository.insert(wordsList.stream().map(BadWordDocument::new).collect(Collectors.toList()))
                .map(document -> modelMapper.map(document, BadWordDTO.class));
    }

    @Override
    public Mono<Void> deleteBadWordById(String id) {
        return badWordRepository.deleteById(id);
    }
}
