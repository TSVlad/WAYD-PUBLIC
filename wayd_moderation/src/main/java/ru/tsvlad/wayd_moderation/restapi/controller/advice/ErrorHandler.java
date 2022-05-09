package ru.tsvlad.wayd_moderation.restapi.controller.advice;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import ru.tsvlad.wayd_moderation.restapi.controller.advice.exceptions.ActiveSessionNotFoundException;
import ru.tsvlad.wayd_moderation.restapi.controller.advice.exceptions.IncorrectBanDurationException;
import ru.tsvlad.wayd_moderation.restapi.controller.advice.exceptions.SessionAlreadyOpenedException;
import ru.tsvlad.wayd_moderation.restapi.controller.advice.exceptions.UserIsAlreadyBannedException;

@ControllerAdvice
public class ErrorHandler {

    @ExceptionHandler({SessionAlreadyOpenedException.class, UserIsAlreadyBannedException.class})
    public ResponseEntity<String> handleConflict(Exception e) {
        return new ResponseEntity<>(getExceptionName(e), HttpStatus.CONFLICT);
    }

    @ExceptionHandler({ActiveSessionNotFoundException.class})
    public ResponseEntity<String> handleNotFound(Exception e) {
        return new ResponseEntity<>(getExceptionName(e), HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler({IncorrectBanDurationException.class})
    public ResponseEntity<String> handleBadRequest(Exception e) {
        return new ResponseEntity<>(getExceptionName(e), HttpStatus.BAD_REQUEST);
    }

    private String getExceptionName(Exception e) {
        String [] exceptionWithPackages = e.getClass().getName().split("\\.");
        return exceptionWithPackages[exceptionWithPackages.length - 1];
    }
}
