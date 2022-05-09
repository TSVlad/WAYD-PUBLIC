import {Col, Row} from "react-bootstrap";
import {useLocation, useParams} from "react-router-dom";
import {useEffect, useState} from "react";
import UserComponent from "../user/UserComponent";
import {getUserByIdRequest} from "../../utills/request/requests/userRequests";
import {useKeycloak} from "@react-keycloak/web";

const UserProfilePage = (props) => {
    const {userId} = useParams()
    const {initialized} = useKeycloak()

    const [user, setUser] = useState(null)
    let location = useLocation()

    useEffect(() => {
        if (userId && initialized) {
            getUserByIdRequest(userId)
                .then(response => {
                    if (response.status === 200) {
                        return response.json()
                    } else {
                        throw response
                    }
                })
                .then(u => {
                    console.log(u)
                    setUser(u)
                })
        }
    }, [userId, initialized, location])

    return (
        <Row>
            <Col sm={3}/>
            <Col>
                {!!user &&
                    <UserComponent user={user} editMode={props.editMode} className={'mt-3'}/>
                }
            </Col>
            <Col sm={3}/>
        </Row>
    )
}

export default UserProfilePage