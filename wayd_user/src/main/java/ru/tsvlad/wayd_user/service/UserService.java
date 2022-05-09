package ru.tsvlad.wayd_user.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import ru.tsvlad.wayd_user.commons.OrganizationRegisterInfo;
import ru.tsvlad.wayd_user.commons.User;
import ru.tsvlad.wayd_user.commons.UserRegisterInfo;
import ru.tsvlad.wayd_user.commons.UserUpdateInfo;
import ru.tsvlad.wayd_user.enums.Role;
import ru.tsvlad.wayd_user.enums.Validity;
import ru.tsvlad.wayd_user.restapi.dto.*;

import java.util.List;

/**
 * Service for providing functionality connected with users.
 */
public interface UserService {
    /**
     * Method for getting page with users by text search
     *
     * @param username String for search
     * @param page Page number
     * @param size Page size
     * @return Page with requested users
     */
    Page<User> getAllActiveByUsername(String username, int page, int size);

    /**
     * Method for getting users by ids.
     *
     * @param ids Users' ids
     * @return List of requested users
     */
    List<User> getAllByIds(List<String> ids);

    /**
     * Method for getting user by id.
     *
     * @param id User's id.
     * @return Requested user
     */
    User getUserById(String id);

    /**
     * Method for registering new user.
     *
     * @param userRegisterInfo Object with information for registration.
     * @return Registered user.
     */
    User registerUser(UserRegisterInfo userRegisterInfo);

    /**
     * Method for registering new organization.
     *
     * @param organizationRegisterInfo Object with information for registration.
     * @return Registered organization.
     */
    User registerOrganization(OrganizationRegisterInfo organizationRegisterInfo);

    /**
     * Method for updating user.
     *
     * @param userUpdateInfo Object with updated user's fields.
     * @return Updated user.
     */
    User updateUser(UserUpdateInfo userUpdateInfo);

    /**
     * Method for updating user's validity.
     *
     * @param id Updated user's id.
     * @param validity New validity value.
     */
    void updateValidBadWords(String id, Validity validity);

    /**
     * Method for blocking user.
     *
     * @param userId Blocked user's id.
     */
    void banUser(String userId);

    /**
     * Method for unblocking user.
     *
     * @param userId Unblocked user's id.
     */
    void unbanUser(String userId);
}
