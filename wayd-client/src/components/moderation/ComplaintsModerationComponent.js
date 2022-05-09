import {useEffect, useState} from "react";
import {getComplaintsRequest, processComplaintRequest} from "../../utills/request/requests/moderationRequest";
import {useKeycloak} from "@react-keycloak/web";
import ComplaintItemComponent from "./ComplaintItemComponent";
import {Modal} from "react-bootstrap";
import CommentModalComponent from "./CommentModalComponent";

const ComplaintsModerationComponent = (props) => {
    const [complaints, setComplaints] = useState([])
    const [chosenComplainedIndex, setChosenComplainedIndex] = useState(-1)
    const [showComment, setShowComment] = useState(false)

    const {initialized} = useKeycloak()

    useEffect(() => {
        if (initialized) {
            getComplaintsRequest(['NEW'], [])
                .then(response => {
                    if (response.status === 200) {
                        return response.json()
                    } else {
                        throw response
                    }
                })
                .then(c => {
                    setComplaints(c)
                })
        }
    }, [initialized])

    return (
        <div className={props.className} style={props.style}>
            {complaints.map((complaint, index) => (
                <ComplaintItemComponent key={complaint.id} complaint={complaint} className={'mt-4'} onAccept={() => {
                    setChosenComplainedIndex(index)
                    setShowComment(true)
                }}/>
            ))}

            <CommentModalComponent show={showComment} onHide={() => setShowComment(false)} onComment={(comment) => {
                processComplaintRequest({
                    complaintId: complaints[chosenComplainedIndex].id,
                    complaintStatus: 'SOLVED',
                    moderatorComment: comment
                })
                    .then(response => {
                        if (response.status === 200) {
                            const newComplaints = [...complaints]
                            newComplaints.splice(chosenComplainedIndex, 1)
                            setComplaints(newComplaints)
                        } else {
                            throw response
                        }
                    })
            }}/>
        </div>
    )
}

export default ComplaintsModerationComponent