import {Col, Row} from "react-bootstrap";
import NotificationListComponent from "../notifications/NotificationListComponent";

const NotificationsPage = () => {
    return (
        <Row>
            <Col sm={3}/>
            <Col>
                <NotificationListComponent className={"mt-5"}/>
            </Col>
            <Col sm={3}/>
        </Row>
    )
}

export default NotificationsPage