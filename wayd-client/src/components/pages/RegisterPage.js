import {Col, Row} from "react-bootstrap";
import {useState} from "react";
import UserEditComponent from "../user/UserEditComponent";

const RegisterPage = () => {

    const [registered, setRegistered] = useState(false)

    return (
        <Row>
            <Col sm={3}/>
            <Col>
                {!registered &&
                    <UserEditComponent registerCallback={() => setRegistered(true)}/>
                }
                {registered &&
                    <h3 className={'mt-5'}>Registered successfully. Confirm your email to use account.</h3>
                }
            </Col>
            <Col sm={3}/>
        </Row>
    )
}

export default RegisterPage