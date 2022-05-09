package ru.tsvlad.wayd_user.restapi.controller.advise.exceptions;

public class ServerException extends RuntimeException{
    public ServerException() {
        super();
    }

    public ServerException(String message) {
        super(message);
    }
}
