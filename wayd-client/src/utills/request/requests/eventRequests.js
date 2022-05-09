import clientRequest from "../clientRequest";
import PATHS from "../../constants/servicesPaths";

const getEventByIdRequest = (id) => {
    return clientRequest(`${PATHS.eventServiceAPI}/event/${id}`)
}

const participateRequest = (eventId) => {
    return clientRequest(`${PATHS.eventServiceAPI}/event/participate/${eventId}`, 'POST')
}

const cancelParticipationRequest = (eventId) => {
    return clientRequest(`${PATHS.eventServiceAPI}/event/participate/${eventId}/cancel`, 'POST')
}

const getEventsByOwnerIdRequest = (userId) => {
    return clientRequest(`${PATHS.eventServiceAPI}/event/user/${userId}`)
}

const getEventsForParticipantIdRequest = (id) => {
    return clientRequest(`${PATHS.eventServiceAPI}/event/participant/${id}`)
}

export {getEventByIdRequest, participateRequest, cancelParticipationRequest, getEventsByOwnerIdRequest, getEventsForParticipantIdRequest}