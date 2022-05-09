import {Col, Row} from "react-bootstrap";
import ReasonsListComponent from "../admin/ReasonsListComponent";

const ReasonsPage = () => {
    return (
        <Row>
            <Col sm={3}/>
            <Col>
                <ReasonsListComponent className={'mt-3'} style={{overflow: 'scroll', maxHeight: '90vh'}}/>
            </Col>
            <Col sm={3}/>
        </Row>
    )
}

export default ReasonsPage