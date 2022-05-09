import {Button, Form, Modal} from "react-bootstrap";
import {useEffect, useState} from "react";
import {getReasonsRequest} from "../../utills/request/requests/moderationRequest";

const BanModalComponent = (props) => {
    const [banInfo, setBanInfo] = useState({
        reason: '',
        comment: '',
        banDuration: 0
    })
    const [reasons, setReasons] = useState([])
    const [selectedReason, setSelectedReason] = useState(null)

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
                        const r = e.target.value ? JSON.parse(e.target.value) : null
                        setSelectedReason(r)
                        setBanInfo({...banInfo, reason: r? r.name : ''})
                    }}>
                        <option value={''}>Choose...</option>
                        {reasons.map(reason => (
                            <option key={reason.id} value={JSON.stringify(reason)}>{reason.name}</option>
                        ))}
                    </Form.Select>
                    <Form.Label>Comment</Form.Label>
                    <Form.Control as={'textarea'} onChange={(e) => {
                        setBanInfo({...banInfo, comment: e.target.value})
                    }}/>

                    {selectedReason && selectedReason.banType === 'UNDETERMINED' &&
                        <div className={'mt-3'}>
                            <Form.Label>Block duration:</Form.Label>
                            <Form.Check label={'Permanent'} onChange={e => {
                                if (e.target.checked) {
                                    setBanInfo({...banInfo, banDuration: -1})
                                } else {
                                    setBanInfo({...banInfo, banDuration: 0})
                                }
                            }
                            }/>

                            {banInfo.banDuration !== -1 && (
                                <Form.Control type={'number'} placeholder={'Block duration in days'} onChange={e => {
                                    if (e.target.value > 0) {
                                        setBanInfo({...banInfo, banDuration: e.target.value})
                                    } else {
                                        setBanInfo({...banInfo, banDuration: 0})
                                    }
                                }}/>
                            )}
                        </div>
                    }
                </Form>
            </Modal.Body>
            <Modal.Footer>
                <Button variant="primary" onClick={() => props.onBan(banInfo)}
                        disabled={!(banInfo.reason && banInfo.comment  && (selectedReason.banType !== 'UNDETERMINED' || banInfo.banDuration !== 0))}>
                    Block
                </Button>
            </Modal.Footer>
        </Modal>
    )
}

export default BanModalComponent