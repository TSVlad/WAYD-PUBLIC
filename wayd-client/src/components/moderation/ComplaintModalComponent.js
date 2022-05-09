import {Button, Form, Modal} from "react-bootstrap";
import {useEffect, useState} from "react";
import {getReasonsRequest} from "../../utills/request/requests/moderationRequest";

const ComplaintModalComponent = (props) => {
    const [reasons, setReasons] = useState([])
    const [complaint, setComplaint] = useState({})

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
                <Modal.Title>Complaint details</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <Form>
                    <Form.Label>Reason</Form.Label>
                    <Form.Select onChange={(e) => {
                        setComplaint({...complaint, reason: e.target.value})
                    }}>
                        <option value={''}>Choose...</option>
                        {reasons.map(reason => (
                            <option key={reason.id} value={reason.name}>{reason.name}</option>
                        ))}
                    </Form.Select>
                    <Form.Label>Topic</Form.Label>
                    <Form.Control onChange={(e) => {
                        setComplaint({...complaint, topic: e.target.value})
                    }}/>
                    <Form.Label>Description</Form.Label>
                    <Form.Control as={'textarea'} onChange={(e) => {
                        setComplaint({...complaint, message: e.target.value})
                    }}/>
                </Form>
            </Modal.Body>
            <Modal.Footer>
                <Button variant="primary" onClick={() => props.onComplain(complaint)} disabled={!(complaint.reason && complaint.topic && complaint.message)}>
                    Complain
                </Button>
            </Modal.Footer>
        </Modal>
    )
}

export default ComplaintModalComponent