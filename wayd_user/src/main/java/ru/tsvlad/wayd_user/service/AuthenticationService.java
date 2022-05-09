package ru.tsvlad.wayd_user.service;

import org.springframework.security.core.Authentication;

/**
 * Service for working with authentication.
 */
public interface AuthenticationService {
    /**
     * Method for getting user's id from spring authentication object.
     *
     * @param authentication Spring authentication object
     * @return User's id
     */
    String getUserId(Authentication authentication);
}
