package ru.tsvlad.waydimage.restapi.controller.advise.exceptions;

public class ServerException extends RuntimeException{
    public ServerException(String message) {
        super(message);
    }

    public ServerException(Throwable cause) {
        super(cause);
    }
}
