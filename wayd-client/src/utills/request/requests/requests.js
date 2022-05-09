import clientRequest from "../clientRequest";
import PATHS from "../../constants/servicesPaths";

const getAllCategoriesRequest = async () => {
    return clientRequest(`${PATHS.eventServiceAPI}/event-category`)
}

const saveEventRequest = (event) => {
    return clientRequest(`${PATHS.eventServiceAPI}/event`, 'POST', event)
}

const uploadImagesRequest = (files) => {
    const body = new FormData()
    for (const file of files) {
        body.append("files", file)
    }
    return clientRequest(`${PATHS.imageServiceAPI}/image`, 'POST', body)
}

const getImageUrlByIdRequest = (id, isMiniature) => {
    return clientRequest(`${PATHS.imageServiceAPI}/image/${id}?miniature=${isMiniature}`)
}

const getImageUrlsByIdsRequest = (ids, isMiniature) => {
    let url = `${PATHS.imageServiceAPI}/image?miniature=${isMiniature}`
    for (const id of ids) {
        url += `&id=${id}`
    }
    return clientRequest(url)
}

export {getAllCategoriesRequest, uploadImagesRequest, getImageUrlByIdRequest, getImageUrlsByIdsRequest, saveEventRequest}