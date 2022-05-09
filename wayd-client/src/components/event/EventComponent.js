import EventEditComponent from "./EventEditComponent";
import EventViewComponent from "./EventViewComponent";
import {Col, Row} from "react-bootstrap";

const EventComponent = (props) => {
    return (
        <Row>
            <Col sm={2}/>
            <Col>
                {props.editMode &&
                <EventEditComponent event={props.event}/>
                }
                {!props.editMode &&
                <EventViewComponent event={props.event}/>
                }
            </Col>
            <Col sm={2}/>
        </Row>
    )
}

export default EventComponent