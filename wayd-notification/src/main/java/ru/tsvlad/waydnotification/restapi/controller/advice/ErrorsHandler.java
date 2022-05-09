package ru.tsvlad.waydnotification.restapi.controller.advice;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import ru.tsvlad.waydnotification.restapi.controller.advice.exceptions.ForbiddenException;
import ru.tsvlad.waydnotification.restapi.controller.advice.exceptions.InvalidTokenException;

@ControllerAdvice
public class ErrorsHandler {

    @ExceptionHandler(value = {InvalidTokenException.class})
    public ResponseEntity<String> handleInvalidToken(Exception e) {
        return new ResponseEntity<>(getExceptionName(e), HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(value = {ForbiddenException.class})
    public ResponseEntity<String> handleForbidden(Exception e) {
        return new ResponseEntity<>(getExceptionName(e), HttpStatus.FORBIDDEN);
    }

    private String getExceptionName(Exception e) {
        String [] exceptionWithPackages = e.getClass().getName().split("\\.");
        return exceptionWithPackages[exceptionWithPackages.length - 1];
    }
}
