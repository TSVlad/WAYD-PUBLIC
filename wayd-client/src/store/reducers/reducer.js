import {SET_SHOW_UNSUCCESSFUL_LOGIN_ALERT_ACTION, SET_USER_ACTION} from "../actions/actionTypes";

const reducer = (state, action) => {
    switch(action.type) {
        case SET_USER_ACTION: return {...state, user: action.user}
        case SET_SHOW_UNSUCCESSFUL_LOGIN_ALERT_ACTION: return {...state, showUnsuccessfulLoginAlert: action.show}
        default: return state;
    }
}

export default reducer