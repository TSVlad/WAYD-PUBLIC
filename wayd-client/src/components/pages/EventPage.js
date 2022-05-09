import {useLocation, useParams} from "react-router-dom";
import EventComponent from "../event/EventComponent";
import {useEffect, useState} from "react";
import {getEventByIdRequest} from "../../utills/request/requests/eventRequests";

const EventPage = (props) => {
    const {eventId} = useParams()
    let location = useLocation()

    const [event, setEvent] = useState({
        name: '',
        description: '',
        contacts: '',
        category: null,
        subCategory: null,
        dateTime: null,

        point: null,
        picturesRefs: [],

        minNumberOfParticipants: 0,
        maxNumberOfParticipants: 0,
        minAge: 0,
        maxAge: 0,
        deadline: null
    })

    useEffect(() => {
        console.log('EFFECT')
        if (eventId) {
            getEventByIdRequest(eventId)
                .then(response => {
                    console.log(response)
                    if (response.status === 200) {
                        return response.json()
                    } else {
                        throw  response.status
                    }
                })
                .then(event => {
                    console.log(event)
                    setEvent(event)
                })
        }
    }, [eventId, location])

    return(
        <EventComponent event={event} editMode={props.edit}/>
    )
}

export default EventPage