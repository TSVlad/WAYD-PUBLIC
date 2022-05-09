import {useEffect, useState} from "react";
import {getReasonsRequest} from "../../utills/request/requests/moderationRequest";
import {Button, Form, Modal} from "react-bootstrap";

const BlockModalComponent = (props) => {
    const [blockInfo, setBlockInfo] = useState({
        reason: '',
        comment: '',
        banDuration: 0
    })
    const [reasons, setReasons] = useState([])

    useEffect(() => {
        getReasonsRequest()
            .then(response => {
                if (response.status === 200) {
                    return response.json()
                } else {
                    throw response
                }
            })
            .then(r => {
                setReasons(r)
            })
    }, [])

    return (
        <Modal show={props.show} onHide={() => {
            props.onHide()
        }}>
            <Modal.Header closeButton>
                <Modal.Title>Block details</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <Form>
                    <Form.Label>Reason</Form.Label>
                    <Form.Select onChange={(e) => {
                        setBlockInfo({...blockInfo, reason: e.target.value})
                    }}>
                        <option value={''}>Choose...</option>
                        {reasons.map(reason => (
                            <option key={reason.id} value={reason.name}>{reason.name}</option>
                        ))}
                    </Form.Select>
                    <Form.Label>Comment</Form.Label>
                    <Form.Control as={'textarea'} onChange={(e) => {
                        setBlockInfo({...blockInfo, comment: e.target.value})
                    }}/>
                </Form>
            </Modal.Body>
            <Modal.Footer>
                <Button variant="primary" onClick={() => props.onBlock(blockInfo)}
                        disabled={!(blockInfo.reason && blockInfo.comment)}>
                    Block
                </Button>
            </Modal.Footer>
        </Modal>
    )
}

export default BlockModalComponent