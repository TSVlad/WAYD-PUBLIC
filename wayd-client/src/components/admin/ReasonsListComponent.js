import {useEffect, useState} from "react";
import {useKeycloak} from "@react-keycloak/web";
import {
    deleteReasonRequest,
    getReasonsRequest,
    saveReasonRequest
} from "../../utills/request/requests/moderationRequest";
import ReasonItemComponent from "./ReasonItemComponent";
import {Button, Row} from "react-bootstrap";
import ReasonEditModal from "./ReasonEditModal";

const ReasonsListComponent = (props) => {
    const [reasons, setReasons] = useState([])
    const [showEdit, setShowEdit] = useState(false)
    const [selectedReason, setSelectedReason] = useState(null)

    const {initialized} = useKeycloak()

    useEffect(() => {
        if (initialized) {
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
        }
    }, [initialized])

    return (
        <div className={props.className} style={props.style}>
            <Row className={'justify-content-center'}>
                <Button variant={'success'} className={'w-50'} onClick={() => {
                    setShowEdit(true)
                }}>Add</Button>
            </Row>
            {reasons.map((reason, index) => (
                <ReasonItemComponent key={reason.id} reason={reason} className={'mt-4'} onDelete={() => {
                    deleteReasonRequest(reason.id)
                        .then(response => {
                            if (response.status === 200) {
                                const newReasons = [...reasons]
                                newReasons.splice(index, 1)
                                setReasons(newReasons)
                            } else {
                                throw response
                            }
                        })
                }} onEdit={() => {
                    setSelectedReason(reason)
                    setShowEdit(true)
                }}/>
            ))}
            <ReasonEditModal show={showEdit} reason={selectedReason} onHide={() => {
                setShowEdit(false)
                setSelectedReason(null)
            }} onSave={reason => {
                saveReasonRequest(reason)
                    .then(response => {
                        if (response.status === 200) {
                            return response.json()
                        } else {
                            setShowEdit(false)
                            setSelectedReason(null)
                            throw response
                        }
                    })
                    .then(r => {
                        setReasons([...(reasons.filter(reason => reason.id !== r.id)), r])
                        setShowEdit(false)
                        setSelectedReason(null)
                    })
            }}/>
        </div>
    )
}

export default ReasonsListComponent