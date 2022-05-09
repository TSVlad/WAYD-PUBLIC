package ru.tsvlad.wayd_moderation.restapi.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;
import ru.tsvlad.wayd_moderation.document.BlockDocument;
import ru.tsvlad.wayd_moderation.restapi.dto.BlockDTO;
import ru.tsvlad.wayd_moderation.service.BlockService;

@RestController
@RequestMapping("/blocks")
@AllArgsConstructor
@Slf4j
public class BlockController {

    private final BlockService blockService;

    private final ModelMapper modelMapper;

    @PostMapping
    public Mono<BlockDTO> block(@RequestBody BlockDTO blockDTO) {
        log.debug("Block request gotten: {}", blockDTO);
        return blockService.block(modelMapper.map(blockDTO, BlockDocument.class))
                .map(blockDocument -> modelMapper.map(blockDocument, BlockDTO.class));
    }
}
