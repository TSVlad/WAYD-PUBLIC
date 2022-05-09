import {Col, Row} from "react-bootstrap";
import OrganizationRegistrationForm from "./OrganizationRegistrationForm";

const OrganizationRegistrationPage = () => {
    return (
        <Row>
            <Col sm={3}/>
            <Col>
                <OrganizationRegistrationForm className={'mt-3'}/>
            </Col>
            <Col sm={3}/>
        </Row>
    )
}

export default OrganizationRegistrationPage