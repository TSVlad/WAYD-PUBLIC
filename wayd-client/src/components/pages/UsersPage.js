import {Col, Row} from "react-bootstrap";
import UserSearchComponent from "../user/UserSearchComponent";

const UsersPage = () => {
    return (
        <Row>
            <Col sm={3}/>
            <Col>
                <UserSearchComponent className={'mt-3'}/>
            </Col>
            <Col sm={3}/>
        </Row>
    )
}

export default UsersPage