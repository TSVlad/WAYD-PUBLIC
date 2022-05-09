import {getShortTextForNotification} from "../../utills/strings";
import '../../css/notification.css'
import NOTIFICATION_STATUSES from "../../utills/constants/notificationStatuses";
import {Col, Row} from "react-bootstrap";
import {isoToLocalDateTimeForShow} from "../../utills/dates";

const NotificationItemComponent = (props) => {
    return (
        <div onClick={props.onClick} className={props.className + ' notification-item'} style={{border: "solid", borderRadius: "15px"}}>
            <Row className={"m-3"}>
                <Col>
                    <h4>
                        {props.notification.status === NOTIFICATION_STATUSES.NEW && (
                            <svg height="30" width="30">
                                <circle cx="15" cy="15" r="5" fill="blue" />
                            </svg>
                        )}
                        {props.notification.subject}
                    </h4>
                    <p>{getShortTextForNotification(props.notification.body, 50)}</p>
                </Col>
                <Col sm={3} className={"text-right"}>
                    <p>{isoToLocalDateTimeForShow(props.notification.timestamp)}</p>
                </Col>
            </Row>
        </div>
    )
}

export default NotificationItemComponent