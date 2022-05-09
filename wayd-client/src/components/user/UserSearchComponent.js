import {Button, Form, FormControl, Row} from "react-bootstrap";
import {getUsersByNameLikeRequest, getUsersRequest} from "../../utills/request/requests/userRequests";
import PaginationComponent from "../commons/PaginationComponent";
import UsersListComponent from "./UsersListComponent";
import {useEffect, useState} from "react";
import ENV from "../../utills/constants/environment";
import {useKeycloak} from "@react-keycloak/web";
import {getImageUrlsByIdsRequest} from "../../utills/request/requests/requests";
import ROLES from "../../utills/constants/roles";
import {connect} from "react-redux";

const UserSearchComponent = (props) => {
    const [users, setUsers] = useState([])
    const [images, setImages] = useState({})

    const [searchName, setSearchName] = useState('')
    const [page, setPage] = useState(0)
    const [pageNumber, setPageNumber] = useState(1)

    const {keycloak, initialized} = useKeycloak()

    const getUsers = () => {
        getUsersRequest(searchName, page, ENV.userPageSize)
            .then(response => {
                if (response.status === 200) {
                    return response.json()
                } else {
                    throw response
                }
            })
            .then(usersPage => {
                setPageNumber(usersPage.totalPages)
                const res = usersPage.content.filter(u => u.id !== keycloak.tokenParsed.sub)
                setUsers(res)
                return res.filter(user => user.avatar).map(user => user.avatar)
            })
            .then(imageNames => {
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

    useEffect(() => {
        if (initialized) {
            getUsers()
        }
    }, [initialized])

    return (
        <Row className={props.className + ' justify-content-center'}>
            {props.authenticatedUser && props.authenticatedUser.realm_access.roles.includes(ROLES.MODERATOR) &&
                <Button className={'w-50'} href={'/organization/register'} variant={'outline-info'}>Add organization</Button>
            }
            <Form className="d-flex mt-3">
                <FormControl
                    type="search"
                    placeholder="Search"
                    className="me-2"
                    aria-label="Search"
                    onChange={(e) => {
                        setSearchName(e.target.value)
                    }}
                />
                <Button variant="outline-success" onClick={() => {
                    setPage(0)
                    getUsers()
                }}>Search</Button>
            </Form>

            <UsersListComponent users={users} images={images}/>

            <PaginationComponent pagesNumber={pageNumber} onPageChange={page => {
                setPage(page)
            }}/>
        </Row>
    )
}

const mapStateToProps = (state) => {
    return {
        authenticatedUser: state.user
    }
}

export default  connect(mapStateToProps)(UserSearchComponent)