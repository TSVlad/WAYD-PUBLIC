package com.example.waydevent.restapi.controller.advice;

import com.example.waydevent.restapi.controller.advice.exceptions.ForbiddenException;
import com.example.waydevent.restapi.controller.advice.exceptions.InvalidAgeException;
import com.example.waydevent.restapi.controller.advice.exceptions.TooManyParticipantsException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ExceptionsHandler {
    @ExceptionHandler({ForbiddenException.class})
    ResponseEntity<String> forbiddenExceptionHandle(Exception e) {
        return new ResponseEntity<>(getExceptionName(e), HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler({TooManyParticipantsException.class, InvalidAgeException.class})
    ResponseEntity<String> conflictHandle(Exception e) {
        return new ResponseEntity<>(getExceptionName(e), HttpStatus.CONFLICT);
    }

    private String getExceptionName(Exception e) {
        String[] arr = e.toString().split("\\.");
        return arr[arr.length - 1];
    }
}
