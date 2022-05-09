import {Button, Form, Modal} from "react-bootstrap";
import {useState} from "react";

const CommentModalComponent = (props) => {
    const [comment, setComment] = useState('')

    return (
        <Modal show={props.show} onHide={() => {
            props.onHide()
        }}>
            <Modal.Header closeButton>
                <Modal.Title>Details</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <Form>
                    <Form.Label>Comment</Form.Label>
                    <Form.Control as={'textarea'} onChange={(e) => {
                        setComment(e.target.value)
                    }}/>
                </Form>
            </Modal.Body>
            <Modal.Footer>
                <Button variant="primary" onClick={() => props.onComment(comment)}>
                    Comment
                </Button>
            </Modal.Footer>
        </Modal>
    )
}

export default CommentModalComponent