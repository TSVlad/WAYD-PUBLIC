import clientRequest from "../clientRequest";
import PATHS from "../../constants/servicesPaths";

const getReasonsRequest = () => {
    return clientRequest(`${PATHS.moderationServiceAPI}/reason`)
}

const complainRequest = (complaint) => {
    return clientRequest(`${PATHS.moderationServiceAPI}/complaint`, 'POST', complaint)
}

const banUserRequest = (banInfo) => {
    return clientRequest(`${PATHS.moderationServiceAPI}/ban`, 'POST', banInfo)
}

const blockRequest = (blockInfo) => {
    return clientRequest(`${PATHS.moderationServiceAPI}/blocks`, 'POST', blockInfo)
}

const getCurrentSessionRequest = () => {
    return clientRequest(`${PATHS.moderationServiceAPI}/session/current`)
}

const startSessionRequest = () => {
    return clientRequest(`${PATHS.moderationServiceAPI}/session/start`, 'POST')
}

const stopSessionRequest = () => {
    return clientRequest(`${PATHS.moderationServiceAPI}/session/close`, 'POST')
}

const getComplaintsRequest = (statuses = [], types = []) => {
    let request = `${PATHS.moderationServiceAPI}/complaint?`
    for (const status of statuses) {
        request += `status=${status}&&`
    }
    for (const type of types) {
        request += `type=${type}&&`
    }
    return clientRequest(request)
}

const processComplaintRequest = (details) => {
    return clientRequest(`${PATHS.moderationServiceAPI}/complaint/process`, 'POST', details)
}

const saveReasonRequest = (reason) => {
    return clientRequest(`${PATHS.moderationServiceAPI}/reason`, 'POST', reason)
}


const deleteReasonRequest = (id) => {
    return clientRequest(`${PATHS.moderationServiceAPI}/reason/${id}`, 'DELETE')
}

export {getReasonsRequest, complainRequest, banUserRequest, blockRequest, getCurrentSessionRequest, startSessionRequest,
    stopSessionRequest, getComplaintsRequest, processComplaintRequest, saveReasonRequest, deleteReasonRequest}