import '../../css/bellComponent.css'
import {useEffect, useState} from "react";
import {
    getNotificationsByStatusesRequest,
    updateNotificationStatus
} from "../../utills/request/requests/notificationRequests";
import NOTIFICATION_STATUSES from "../../utills/constants/notificationStatuses";
import {isoToLocalDateTimeForShow} from "../../utills/dates";
import {Button, Col, Modal, Row} from "react-bootstrap";
import {getTextWithoutTags} from "../../utills/strings";
import {connect} from "react-redux";
import {useKeycloak} from "@react-keycloak/web";

const NotificationBellComponent = (props) => {
    const [showNotifications, setShowNotifications] = useState(false)
    const [notifications, setNotifications] = useState([])
    const [selectedNotification, setSelectedNotification] = useState(null)
    const [showNotificationModal, setShowNotificationModal] = useState(false)

    const {initialized} = useKeycloak()

    useEffect(() => {
        if (initialized) {
            getNotificationsByStatusesRequest([NOTIFICATION_STATUSES.NEW])
                .then(response => {
                    if (response.status === 200) {
                        return response.json()
                    } else {
                        throw response
                    }
                })
                .then(notifications => {
                    setNotifications(notifications.sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp)))
                })
        }
    }, [initialized])

    const readMessage = (index) => {
        updateNotificationStatus(notifications[index].id, NOTIFICATION_STATUSES.READ)
            .then(response => {
                if (response.status === 200) {
                    const newNotifications = [...notifications]
                    newNotifications.splice(index, 1)
                    setNotifications(newNotifications)
                } else {
                    throw response
                }
            })
    }

    return (
        <div>
            <div className="icon" id="bell" onClick={() => {
                setShowNotifications(!showNotifications)
            }}>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                     className="bi bi-bell-fill" viewBox="0 0 16 16">
                    <path
                        d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
                </svg>
            </div>
            {showNotifications && (
                <div className="notifications" id="box">
                    <h2>Unread notifications - <span>{notifications.length}</span></h2>
                    {notifications.map((notification, index) => (
                        <div key={notification.id}>
                        {index < 5 && (
                            <Row className="notifications-item">
                                <Col className="text" onClick={() => {
                                    setSelectedNotification(notification)
                                    setShowNotificationModal(true)
                                    readMessage(index)
                                }}>
                                    <h4>{notification.subject}</h4>
                                    <p>{getTextWithoutTags(notification.body).substr(0, 30) + '...'}</p>
                                    <p>{isoToLocalDateTimeForShow(notification.timestamp)}</p>
                                </Col>
                                <Col sm={3}>
                                    <Button onClick={() => readMessage(index)}>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" className="bi bi-check-lg" viewBox="0 0 16 16">
                                            <path
                                                d="M12.736 3.97a.733.733 0 0 1 1.047 0c.286.289.29.756.01 1.05L7.88 12.01a.733.733 0 0 1-1.065.02L3.217 8.384a.757.757 0 0 1 0-1.06.733.733 0 0 1 1.047 0l3.052 3.093 5.4-6.425a.247.247 0 0 1 .02-.022Z"/>
                                        </svg>
                                    </Button>
                                </Col>
                            </Row>
                        )}
                        </div>
                    ))}
                    <div className={"w-100 text-center"}>
                        <a href={'/notifications/'}>All</a>
                    </div>
                </div>
            )}

            <Modal
                size="lg"
                show={showNotificationModal && !!selectedNotification}
                onHide={() => setShowNotificationModal(false)}
                aria-labelledby="example-modal-sizes-title-lg"
            >
                <Modal.Header closeButton>
                    <Modal.Title id="example-modal-sizes-title-lg">
                        {!!selectedNotification && selectedNotification.subject}
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body dangerouslySetInnerHTML={!!selectedNotification && {__html:selectedNotification.body}}/>
            </Modal>
        </div>
    )
}

const mapStateToProps = (state) => {
    return {
        user: state.user
    }
}

export default connect(mapStateToProps)(NotificationBellComponent)