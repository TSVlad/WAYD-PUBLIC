import WindowComponent from "./window/WindowComponent";
import LocationMarker from "./markers/LocationMarker";
import EventMarkers from "./markers/EventMarkers";
import {useMapEvents} from "react-leaflet";
import clientRequest from "../../utills/request/clientRequest";
import PATHS from "../../utills/constants/servicesPaths";
import {useEffect, useState} from "react";
import {getImageUrlsByIdsRequest} from "../../utills/request/requests/requests";
import {useKeycloak} from "@react-keycloak/web";

const CustomMapComponents = () => {
    const[events, setEvents] = useState([]);
    const[selectedEvent, setSelectedEvent] = useState(null)
    const [eventsImagesUrls, setEventsImagesUrls] = useState({})
    const [clusterKey, setClusterKey] = useState(0)
    const [filter, setFilter] = useState({
        category: null,
        subcategory: null,
        dateAfter: null,
        dateBefore: null
    })
    const {initialized} = useKeycloak()

    useEffect(() => {
        incrementClusterKey()
        fetchEvents()
    }, [filter])

    useEffect(() => {
        const imageIds = events.filter(event => !!event.picturesRefs && event.picturesRefs.length > 0).map(event => event.picturesRefs[0])
        if (imageIds.length > 0) {
            getImageUrlsByIdsRequest(imageIds, true)
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
                    setEventsImagesUrls(newUrls)
                })
        }
        setEventsImagesUrls({})
    }, [events, initialized])

    const onMapMove = () => {
        incrementClusterKey()
        fetchEvents()
    }

    const onMapClick = () => {
        setSelectedEvent(null)
    }

    const incrementClusterKey = () => {
        setClusterKey(clusterKey + 1)
    }

    const fetchEvents = () => {
        const bounds = map.getBounds()
        clientRequest(`${PATHS.eventServiceAPI}/event/all-in-poly`, 'POST', {
            ...filter,
            geoJsonPolygon: {
                type: 'Polygon',
                coordinates: [
                    [
                        [bounds.getNorthWest().lat, bounds.getNorthWest().lng],
                        [bounds.getSouthWest().lat, bounds.getSouthWest().lng],
                        [bounds.getSouthEast().lat, bounds.getSouthEast().lng],
                        [bounds.getNorthEast().lat, bounds.getNorthEast().lng],
                        [bounds.getNorthWest().lat, bounds.getNorthWest().lng]
                    ]
                ]
            }
        })
            .then(response => {
                if (response.status === 200) {
                    response.json().then(eventsResponse => {
                        setEvents(eventsResponse)
                    })
                }
            })
    }

    const map = useMapEvents({
        moveend: onMapMove,
        click: onMapClick
    });

    useEffect(() => {
        map.doubleClickZoom.disable();
    }, [map])

    return (
        <div>
            <WindowComponent events={events} imageMap={eventsImagesUrls} selectedEvent={selectedEvent} applyFilter={(filter) => setFilter(filter)}/>
            <LocationMarker startByDefault={true}/>
            <EventMarkers clusterKey={clusterKey} events={events} onMarkerSelect={event => setSelectedEvent(event)}/>
        </div>

    )
}

export default CustomMapComponents