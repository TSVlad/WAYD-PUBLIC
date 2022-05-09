package ru.tsvlad.waydnotification.restapi.controller.advice.exceptions;

public class ConflictException extends RuntimeException{
    public ConflictException() {
        super();
    }

    public ConflictException(String message) {
        super(message);
    }
}
