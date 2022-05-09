import EventListItemComponent from "./EventListItemComponent";
import {useEffect, useState} from "react";
import {getEventToImageMap} from "../../utills/images";
import {useKeycloak} from "@react-keycloak/web";

const EventListComponent = (props) => {
    const [eventToImageMap, setEventToImageMap] = useState({})
    const {initialized} = useKeycloak()

    useEffect(() => {
        getEventToImageMap(props.events)
            .then(eventToImageMap => {
                setEventToImageMap(eventToImageMap)
            })
    }, [props.events, initialized])

    return (
        <div style={props.style}>
            {props.events && props.events.map(event => (
                <EventListItemComponent className={'mt-3'} key={event.id} event={event} imageUrl={eventToImageMap[event.picturesRefs[0]]}/>
            ))}
        </div>
    )
}

export default EventListComponent