package ru.tsvlad.wayd_user.utils;

import org.modelmapper.ModelMapper;

public class MappingUtils {
    private final static ModelMapper modelMapper = new ModelMapper();

    public static <T> T map(Object obj, Class<T> clazz) {
        return modelMapper.map(obj, clazz);
    }
}
