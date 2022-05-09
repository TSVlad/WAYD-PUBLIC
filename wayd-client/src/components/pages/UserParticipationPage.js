import {Col, Row} from "react-bootstrap";
import {useEffect, useState} from "react";
import {useParams} from "react-router-dom";
import {getEventsForParticipantIdRequest} from "../../utills/request/requests/eventRequests";
import EventListComponent from "../event/EventListComponent";

const UserParticipationPage = () => {
    const {userId} = useParams()
    const [events, setEvents] = useState([])

    useEffect(() => {
        getEventsForParticipantIdRequest(userId)
            .then(response => {
                if (response.status === 200) {
                    return response.json()
                } else {
                    throw response
                }
            })
            .then(events => {
                setEvents(events)
            })
    }, [userId])

    return (
        <Row>
            <Col sm={3}/>
            <Col>
                <EventListComponent style={{overflow: 'scroll', maxHeight: '90vh'}} events={events}/>
            </Col>
            <Col sm={3}/>
        </Row>
    )
}

export default UserParticipationPage