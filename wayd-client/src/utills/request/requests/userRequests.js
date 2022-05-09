import clientRequest from "../clientRequest";
import PATHS from "../../constants/servicesPaths";

const getUserByIdRequest = (id) => {
    return clientRequest(`${PATHS.userServiceAPI}/user/${id}`)
}

const updateUserRequest = (userInfo) => {
    return clientRequest(`${PATHS.userServiceAPI}/user`, 'PUT', userInfo)
}

const registerRequest = (userInfo) => {
    return clientRequest(`${PATHS.userServiceAPI}/user/register`, 'POST', userInfo)
}

const getUsersByIdsRequest = (ids) => {
    return clientRequest(`${PATHS.userServiceAPI}/user/by-ids`, 'POST', ids)
}

const getUsersRequest = (searchString, page, size) => {
    return clientRequest(`${PATHS.userServiceAPI}/user?searchString=${searchString}&page=${page}&size=${size}`)
}

const registerOrganizationRequest = (info) => {
    return clientRequest(`${PATHS.userServiceAPI}/user/register/organization`, 'POST', info)
}

export {getUserByIdRequest, updateUserRequest, registerRequest, getUsersByIdsRequest, getUsersRequest,
    registerOrganizationRequest}