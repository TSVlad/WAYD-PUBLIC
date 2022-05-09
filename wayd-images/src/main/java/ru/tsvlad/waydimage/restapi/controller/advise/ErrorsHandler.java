package ru.tsvlad.waydimage.restapi.controller.advise;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import ru.tsvlad.waydimage.restapi.controller.advise.exceptions.BadImageException;
import ru.tsvlad.waydimage.restapi.controller.advise.exceptions.ServerException;
import ru.tsvlad.waydimage.restapi.controller.advise.exceptions.UnsupportedImageTypeException;

@ControllerAdvice
public class ErrorsHandler {
    @ExceptionHandler(value = {UnsupportedImageTypeException.class, BadImageException.class})
    ResponseEntity<String> unsupportedMediaTypeHandle(Exception e) {
        return new ResponseEntity<>(getExceptionName(e), HttpStatus.UNSUPPORTED_MEDIA_TYPE);
    }

    @ExceptionHandler({ServerException.class})
    ResponseEntity<HttpStatus> serverErrorHandle() {
        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    private String getExceptionName(Exception e) {
        String[] arr = e.toString().split("\\.");
        return arr[arr.length - 1];
    }
}
