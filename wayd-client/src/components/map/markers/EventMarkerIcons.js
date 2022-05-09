import L from "leaflet";

const eventMarkerIcons = {
    football_personal: L.icon({
        iconUrl: require('../../../icons/football_personal.png'),
        iconSize: [48, 48],
        iconAnchor: [24, 48]
    }),

    football_organizational: L.icon({
        iconUrl: require('../../../icons/football_organizational.png'),
        iconSize: [48, 48],
        iconAnchor: [24, 48]
    }),

    sport_personal: L.icon({
        iconUrl: require('../../../icons/sport_personal.png'),
        iconSize: [48, 48],
        iconAnchor: [24, 48]
    }),

    sport_organizational: L.icon({
        iconUrl: require('../../../icons/sport_organizational.png'),
        iconSize: [48, 48],
        iconAnchor: [24, 48]
    }),

    walk_personal: L.icon({
        iconUrl: require('../../../icons/walk_personal.png'),
        iconSize: [48, 48],
        iconAnchor: [24, 48]
    }),

    walk_organizational: L.icon({
        iconUrl: require('../../../icons/walk_organizational.png'),
        iconSize: [48, 48],
        iconAnchor: [24, 48]
    }),

    basketball_personal: L.icon({
        iconUrl: require('../../../icons/basketball_personal.png'),
        iconSize: [48, 48],
        iconAnchor: [24, 48]
    }),

    basketball_organizational: L.icon({
        iconUrl: require('../../../icons/basketball_organizational.png'),
        iconSize: [48, 48],
        iconAnchor: [24, 48]
    }),

    volleyball_personal: L.icon({
        iconUrl: require('../../../icons/volleyball_personal.png'),
        iconSize: [48, 48],
        iconAnchor: [24, 48]
    }),

    volleyball_organizational: L.icon({
        iconUrl: require('../../../icons/volleyball_organizational.png'),
        iconSize: [48, 48],
        iconAnchor: [24, 48]
    }),
}

let defaultIcon = L.icon({
    iconUrl: require('leaflet/dist/images/marker-icon.png'),
    iconSize: [24, 40],
    iconAnchor: [12, 40]
});

const getMarkerIconForEvent = event => {
    let category = '';
    if(event.subCategory) {
        category = event.subCategory.toLowerCase()
    } else {
        category = event.category.toLowerCase()
    }
    const icon = eventMarkerIcons[`${category}_${event.type.toLowerCase()}`]
    if (!icon) {
        return defaultIcon
    }
    return icon
}

export {getMarkerIconForEvent}