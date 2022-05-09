import {Col, Row} from "react-bootstrap";
import BanWordsComponent from "../admin/BanWordsComponent";

const BanWordsPage = () => {
    return (
        <Row>
            <Col sm={3}/>
            <Col>
                <BanWordsComponent className={'mt-3'}/>
            </Col>
            <Col sm={3}/>
        </Row>
    )
}

export default BanWordsPage