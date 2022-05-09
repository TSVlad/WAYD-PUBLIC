const isoToLocalDateTime = (isoDate) => {
    const date = new Date(isoDate)
    date.setMinutes(date.getMinutes() - date.getTimezoneOffset())
    return date.toISOString().slice(0, 16)
}

const isoToLocalDateTimeForShow = (isoDate) => {
    const localDateTime = isoToLocalDateTime(isoDate)
    return localDateTime.substr(0, 10) + ' ' + localDateTime.substr(11, localDateTime.length)
}

export {isoToLocalDateTime, isoToLocalDateTimeForShow}