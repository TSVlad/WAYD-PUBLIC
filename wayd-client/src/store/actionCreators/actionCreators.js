import {SET_SHOW_UNSUCCESSFUL_LOGIN_ALERT_ACTION, SET_USER_ACTION} from "../actions/actionTypes";

const setUserAction = (user) => {
    return {
        type: SET_USER_ACTION,
        user
    }
}

const setShowUnsuccessfulLoginAlertAction = (show) => {
    return {
        type: SET_SHOW_UNSUCCESSFUL_LOGIN_ALERT_ACTION,
        show
    }
}

export {setUserAction, setShowUnsuccessfulLoginAlertAction}