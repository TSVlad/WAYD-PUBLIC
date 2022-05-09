package ru.tsvlad.wayd_user.restapi.controller.advise.exceptions;

public class ConflictException extends RuntimeException{
    public ConflictException() {
        super();
    }

    public ConflictException(String message) {
        super(message);
    }
}
