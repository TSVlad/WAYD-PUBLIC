const getTextWithoutTags = (str) => str.replace(/<\/?[^>]+(>|$)/g, "")

const getShortTextForNotification = (str, length) => {
    const strWithoutTags = getTextWithoutTags(str)
    if (strWithoutTags.length > length) {
        return strWithoutTags.substr(strWithoutTags, length) + '...';
    }
    return strWithoutTags
}

export {getTextWithoutTags, getShortTextForNotification}