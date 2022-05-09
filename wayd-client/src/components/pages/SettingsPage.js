import {Col, Row} from "react-bootstrap";
import NotificationSettingsComponent from "../settings/NotificationSettingsComponent";

const SettingsPage = () => {
    return (
        <Row>
            <Col sm={3}/>
            <Col>
                <h2 className={'mt-3'}>Settings</h2>
                <NotificationSettingsComponent className={'mt-5'}/>
            </Col>
            <Col sm={3}/>
        </Row>
    )
}

export default SettingsPage