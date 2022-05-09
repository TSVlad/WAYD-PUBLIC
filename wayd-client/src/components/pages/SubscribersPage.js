import {useKeycloak} from "@react-keycloak/web";
import {useEffect, useState} from "react";
import {getSubscribersRequest, getSubscriptionsRequest} from "../../utills/request/requests/notificationRequests";
import {getUsersByIdsRequest} from "../../utills/request/requests/userRequests";
import {getImageUrlsByIdsRequest} from "../../utills/request/requests/requests";
import {Col, Row} from "react-bootstrap";
import UsersListComponent from "../user/UsersListComponent";

const SubscribersPage = () => {
    const [users, setUsers] = useState([])
    const [images, setImages] = useState({})
    const {initialized} = useKeycloak()

    useEffect(() => {
        if (initialized) {
            getSubscribersRequest()
                .then(response => {
                    if (response.status === 200) {
                        return response.json()
                    } else {
                        throw response
                    }
                })
                .then(ids => {
                    return getUsersByIdsRequest(ids)
                })
                .then(response => {
                    if (response.status === 200) {
                        return response.json()
                    } else {
                        throw response
                    }
                })
                .then(u => {
                    setUsers(u)
                    const imageNames = u.filter(user => user.avatar).map(user => user.avatar)
                    if (imageNames.length > 0) {
                        getImageUrlsByIdsRequest(imageNames, true)
                            .then(response => {
                                if (response.status === 200) {
                                    return response.json()
                                } else {
                                    throw response
                                }
                            })
                            .then(imageDtos => {
                                const images = {}
                                for (const imageDto of imageDtos) {
                                    images[imageDto.id] = imageDto.url
                                }
                                setImages(images)
                            })
                    }
                })

        }
    }, [initialized])

    return (
        <Row>
            <Col sm={3}/>
            <Col>
                <UsersListComponent users={users} images={images} style={{overflow: 'scroll', maxHeight: '90vh'}}/>
            </Col>
            <Col sm={3}/>
        </Row>
    )
}
export default SubscribersPage