import {useEffect, useState} from "react";
import {getAllNotificationRequest, updateNotificationStatus} from "../../utills/request/requests/notificationRequests";
import ENV from "../../utills/constants/environment";
import NotificationItemComponent from "./NotificationItemComponent";
import {Modal} from "react-bootstrap";
import NOTIFICATION_STATUSES from "../../utills/constants/notificationStatuses";
import PaginationComponent from "../commons/PaginationComponent";
import {useKeycloak} from "@react-keycloak/web";

const NotificationListComponent = (props) => {
    const [page, setPage] = useState(0)
    const [pagesNumber, setPagesNumber] = useState(1)
    const [notifications, setNotifications] = useState([])
    const [selectedNotification, setSelectedNotification] = useState(null)
    const [showNotificationModal, setShowNotificationModal] = useState(false)

    const {initialized} = useKeycloak()

    useEffect(() => {
        getAllNotificationRequest(page, ENV.notificationPageSize)
            .then(response => {
                if (response.status === 200) {
                    return response.json()
                } else {
                    throw response
                }
            })
            .then(response => {
                setNotifications(response.content)
                setPagesNumber(response.totalPages)
            })
    }, [page, initialized])

    const readMessage = (index) => {
        updateNotificationStatus(notifications[index].id, NOTIFICATION_STATUSES.READ)
            .then(response => {
                if (response.status === 200) {
                    notifications[index].status = NOTIFICATION_STATUSES.READ
                    const newNotifications = [...notifications]
                    setNotifications(newNotifications)
                } else {
                    throw response
                }
            })
    }

    return (
        <div className={props.className}>
            {notifications.map((notification, index) => (
                <NotificationItemComponent key={notification.id} className={"mt-3"} notification={notification} onClick={() => {
                    setSelectedNotification(notification)
                    setShowNotificationModal(true)
                    readMessage(index)
                }}/>
            ))}

            <PaginationComponent pagesNumber={pagesNumber} onPageChange={(newPage) => {
                setPage(newPage)
            }}/>

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

export default NotificationListComponent