import {Button, Form, Row} from "react-bootstrap";
import {registerOrganizationRequest} from "../../utills/request/requests/userRequests";
import {useState} from "react";
import {useHistory} from "react-router-dom";

const OrganizationRegistrationForm = (props) => {
    const [info, setInfo] = useState({
        username: '',
        email: ''
    })

    const history = useHistory()

    return (
        <Form className={props.className}>
            <Form.Label>Username</Form.Label>
            <Form.Control placeholder={'username'} value={info.username} onChange={e => {
                setInfo({...info, username: e.target.value})
            }}/>
            <Form.Label className={'mt-2'}>Email</Form.Label>
            <Form.Control type={'email'} placeholder={'email'} value={info.email} onChange={e => {
                setInfo({...info, email: e.target.value})
            }}/>
            <Row className={'justify-content-center mt-3'}>
                <Button className={'w-25'} disabled={!info.email || !info.username} onClick={() => {
                    registerOrganizationRequest(info)
                        .then(response => {
                            if (response.status === 200) {
                                history.push('/')
                            } else {
                                throw response
                            }
                        })
                }}>Create</Button>
            </Row>
        </Form>
    )
}

export default OrganizationRegistrationForm