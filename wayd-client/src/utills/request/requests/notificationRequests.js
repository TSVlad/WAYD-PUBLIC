import clientRequest from "../clientRequest";
import PATHS from "../../constants/servicesPaths";


const getNotificationsByStatusesRequest = (statuses) => {
    let uri = `${PATHS.notificationServiceAPI}/notification?`
    for (const status of statuses) {
        uri += `status=${status}&`
    }
    return clientRequest(uri)
}

const updateNotificationStatus = (id, status) => {
    return clientRequest(`${PATHS.notificationServiceAPI}/notification/${id}/update-status`, 'POST', status)
}

const getAllNotificationRequest = (page, size) => {
    return clientRequest(`${PATHS.notificationServiceAPI}/notification/all/${page}/${size}`)
}

const getSendNotificationRequest = () => {
    return clientRequest(`${PATHS.notificationServiceAPI}/user/send-email`)
}

const setSendNotificationRequest = (value) => {
    return clientRequest(`${PATHS.notificationServiceAPI}/user/send-email`, 'POST', value)
}

const getSubscriptionsRequest = () => {
    return clientRequest(`${PATHS.notificationServiceAPI}/subscription`)
}

const getSubscribersRequest = () => {
    return clientRequest(`${PATHS.notificationServiceAPI}/subscription/to`)
}

const subscribeRequest = (userId) => {
    return clientRequest(`${PATHS.notificationServiceAPI}/subscription/${userId}`, 'POST')
}

const unsubscribeRequest = (userId) => {
    return clientRequest(`${PATHS.notificationServiceAPI}/subscription/${userId}`, 'DELETE')
}

export {getNotificationsByStatusesRequest, updateNotificationStatus, getAllNotificationRequest,
    getSendNotificationRequest, setSendNotificationRequest, getSubscriptionsRequest, subscribeRequest, unsubscribeRequest,
    getSubscribersRequest
}