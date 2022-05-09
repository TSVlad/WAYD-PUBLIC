import clientRequest from "../clientRequest";
import PATHS from "../../constants/servicesPaths";

const getBanWordsRequest = () => {
    return clientRequest(`${PATHS.validatorServiceAPI}/bad-words`)
}

const deleteBanWordRequest = (id) => {
    return clientRequest(`${PATHS.validatorServiceAPI}/bad-words/${id}`, 'DELETE')
}

const createBanWordRequest = (word) => {
    console.log(word)
    return clientRequest(`${PATHS.validatorServiceAPI}/bad-words`, 'POST', word)
}

export {getBanWordsRequest, deleteBanWordRequest, createBanWordRequest}