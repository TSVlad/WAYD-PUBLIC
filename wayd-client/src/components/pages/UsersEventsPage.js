import {useParams} from "react-router-dom";
import {useEffect, useState} from "react";
import {Col, Row} from "react-bootstrap";
import EventListComponent from "../event/EventListComponent";
import {getEventsByOwnerIdRequest} from "../../utills/request/requests/eventRequests";

const UsersEventsPage = () => {
    const {userId} = useParams()
    const [events, setEvents] = useState([])

    useEffect(() => {
        getEventsByOwnerIdRequest(userId)
            .then(response => {
                if (response.status === 200) {
                    return response.json()
                } else {
                    throw response
                }
            })
            .then(events => {
                setEvents(events.sort((a, b) => {
                    return new Date(b.dateTime) - new Date(a.dateTime)
                }))
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

export default UsersEventsPage