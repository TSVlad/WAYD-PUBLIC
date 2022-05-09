import {getImageUrlsByIdsRequest} from "./request/requests/requests";

const getEventToImageMap = async (events) => {
    const imageIds = events.filter(event => !!event.picturesRefs && event.picturesRefs.length > 0).map(event => event.picturesRefs[0])
    if (imageIds.length > 0) {
        return getImageUrlsByIdsRequest(imageIds, true)
            .then(response => {
                if (response.status === 200) {
                    return response.json()
                } else {
                    throw response
                }
            })
            .then(images => {
                const newUrls = {}
                images.map(image => newUrls[image.id] = image.url)
                return newUrls
            })
    }
    return {}
}

export {getEventToImageMap}