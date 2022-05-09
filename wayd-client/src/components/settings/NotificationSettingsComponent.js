import {Form} from "react-bootstrap";
import {useEffect, useState} from "react";
import {
    getSendNotificationRequest,
    setSendNotificationRequest
} from "../../utills/request/requests/notificationRequests";
import {useKeycloak} from "@react-keycloak/web";

const NotificationSettingsComponent = (props) => {

    const {initialized} = useKeycloak()

    const [emailNotifications, setEmailNotifications] = useState(false)

    useEffect(() => {
        if (initialized) {
            getSendNotificationRequest()
                .then(response => {
                    if (response.status === 200) {
                        return response.json()
                    } else {
                        throw response
                    }
                })
                .then(value => {
                    setEmailNotifications(value)
                })
        }
    }, [initialized])

    return (
        <div style={props.style} className={props.className}>
            <Form>
                <Form.Check
                    type="switch"
                    id="custom-switch"
                    label="Email notifications"
                    checked={emailNotifications}
                    onChange={(e) => {
                        setSendNotificationRequest(e.target.checked)
                        setEmailNotifications(e.target.checked)
                    }}
                />
            </Form>
        </div>
    )
}

export default NotificationSettingsComponent