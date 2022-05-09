import {Button, Form, Modal} from "react-bootstrap";
import {useEffect, useState} from "react";

const ReasonEditModal = (props) => {
    const [reason, setReason] = useState(props.reason ? props.reason
        : {
            name: '',
            banType: 'DETERMINED',
            baseBanDuration: 0,
        })

    useEffect(() => {
        setReason(props.reason ? props.reason
            : {
                name: '',
                banType: 'DETERMINED',
                baseBanDuration: 0,
            })
    }, [props])

    return (
        <Modal show={props.show} onHide={() => {
            props.onHide()
        }}>
            <Modal.Header closeButton>
                <Modal.Title>Reason details</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <Form>
                    <Form.Label>Reason</Form.Label>
                    <Form.Control value={reason.name} onChange={(e) => {
                        setReason({...reason, name: e.target.value})
                    }}/>
                    <Form.Label className={'mt-2'}>Ban type</Form.Label>
                    <Form.Check type={'radio'} label={'determined'} checked={reason.banType === "DETERMINED"}
                                onClick={() => {
                                    setReason({...reason, banType: 'DETERMINED'})
                                }}/>
                    <Form.Check type={'radio'} label={'undetermined'} checked={reason.banType === "UNDETERMINED"}
                                onClick={() => {
                                    setReason({...reason, banType: 'UNDETERMINED'})
                                }}/>
                    <Form.Check type={'radio'} label={'permanent'} checked={reason.banType === "PERMANENT"}
                                onClick={() => {
                                    setReason({...reason, banType: 'PERMANENT'})
                                }}/>
                    {reason.banType === 'DETERMINED' && (
                        <>
                            <Form.Label className={'mt-2'}>Base ban duration</Form.Label>
                            <Form.Control type={'number'} value={reason.baseBanDuration} onChange={e => {
                                setReason({...reason, baseBanDuration: parseInt(e.target.value)})
                            }}/>
                        </>
                    )}
                </Form>
            </Modal.Body>
            <Modal.Footer>
                <Button variant="primary" onClick={() => props.onSave(reason)}
                        disabled={(reason.banType === 'DETERMINED' && reason.baseBanDuration <= 0) || !reason.name}>
                    Save
                </Button>
            </Modal.Footer>
        </Modal>
    )
}

export default ReasonEditModal