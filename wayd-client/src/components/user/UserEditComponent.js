import {Button, Col, Form, Image, Row} from "react-bootstrap";
import LINKS from "../../utills/constants/links";
import {useEffect, useRef, useState} from "react";
import {registerRequest, updateUserRequest} from "../../utills/request/requests/userRequests";
import {useHistory} from "react-router-dom";
import {getImageUrlByIdRequest, uploadImagesRequest} from "../../utills/request/requests/requests";

const UserEditComponent = (props) => {

    const [userInfo, setUserInfo] = useState(props.user ? props.user : {})
    const [avatarUrl, setAvatarUrl] = useState(null)

    const history = useHistory()
    const inputRef = useRef(null)

    useEffect(() => {
        if (props.user) {
            setUserInfo(props.user)
            if (props.user.avatar) {
                console.log('AVATAR')
                getImageUrlByIdRequest(props.user.avatar, true)
                    .then(response => {
                        if (response.status === 200) {
                            return response.json()
                        } else {
                            throw response
                        }
                    })
                    .then(dto => {
                        setAvatarUrl(dto.url)
                    })
            }
        }
    }, [props])

    const getUpdateInfo = () => {
        return {
            id: userInfo.id,
            name: userInfo.name,
            surname: userInfo.surname,
            contacts: userInfo.contacts,
            description: userInfo.description,
            avatar: userInfo.avatar
        }
    }

    const uploadImage = (files) => {
        uploadImagesRequest(files)
            .then(response => {
                if (response.status === 200) {
                    return response.json()
                } else {
                    throw response
                }
            })
            .then(names => {
                setUserInfo({...userInfo, avatar: names[0]})
                return getImageUrlByIdRequest(names[0], true)
            })
            .then(response => {
                if (response.status === 200) {
                    return response.json()
                } else {
                    throw response
                }
            })
            .then(dto => {
                setAvatarUrl(dto.url)
            })
    }

    return (
        <Form className={props.className}>
            <Row>
                {props.user &&
                    <Col sm={4}>
                        <div className="avatar-div mr-1" style={{display: "inline-block"}}>
                            <Image src={avatarUrl ? avatarUrl : LINKS.defaultAvatarLink}
                                   className="avatar"/>
                            {avatarUrl &&
                                <Button variant={'danger'} className={'delete-image-btn'}
                                        onClick={() => {
                                            setUserInfo({...userInfo, avatar: null})
                                            setAvatarUrl(null)
                                        }}>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         className="bi bi-trash-fill" viewBox="0 0 16 16">
                                        <path
                                            d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1H2.5zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5zM8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5zm3 .5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 1 0z"/>
                                    </svg>
                                </Button>
                            }
                        </div>
                        <div>
                            <Form.Control className="d-none" type="file" ref={inputRef} accept=".png, .jpg, .jpeg" onChange={e => {
                                uploadImage(e.target.files)
                            }}/>
                            <Button variant={"secondary"} className={'w-100'} onClick={() => {
                                inputRef.current?.click()
                            }}>Change avatar</Button>
                        </div>
                    </Col>
                }
                <Col>
                    {!props.user &&
                        <>
                            <Form.Label className={'mt-2'}>Username*</Form.Label>
                            <Form.Control onChange={(e) => setUserInfo({...userInfo, username: e.target.value})}/>
                            <Form.Label className={'mt-2'}>Password*</Form.Label>
                            <Form.Control type={'password'}
                                          onChange={(e) => setUserInfo({...userInfo, password: e.target.value})}/>
                            <Form.Label className={'mt-2'}>Email*</Form.Label>
                            <Form.Control type={'email'}
                                          onChange={(e) => setUserInfo({...userInfo, email: e.target.value})}/>
                            <Form.Label className={'mt-2'}>Date of birth*</Form.Label>
                            <Form.Control type={'date'} onChange={(e) => {
                                setUserInfo({...userInfo, dateOfBirth: e.target.value})
                            }}/>
                        </>
                    }
                    <Form.Label>Name</Form.Label>
                    <Form.Control defaultValue={userInfo.name}
                                  onChange={(e) => setUserInfo({...userInfo, name: e.target.value})}/>
                    {(!props.user || props.user.roles.includes('ROLE_PERSON')) &&
                        <>
                            <Form.Label className={'mt-2'}>Surname</Form.Label>
                            <Form.Control defaultValue={userInfo.surname}
                                          onChange={(e) => setUserInfo({...userInfo, surname: e.target.value})}/>
                        </>
                    }

                </Col>
            </Row>
            <Form.Label className={'mt-2'}>Contacts</Form.Label>
            <Form.Control defaultValue={userInfo.contacts}
                          onChange={(e) => setUserInfo({...userInfo, contacts: e.target.value})}/>
            <Form.Label className={'mt-2'}>Description</Form.Label>
            <Form.Control as={'textarea'} rows={4} defaultValue={userInfo.description}
                          onChange={(e) => setUserInfo({...userInfo, description: e.target.value})}/>
            <Row className="justify-content-center mt-3">
                <Button onClick={() => {
                    if (props.user) {
                        updateUserRequest(getUpdateInfo())
                            .then(response => {
                                if (response.status === 202) {
                                    history.push(`/user/${props.user.id}`)
                                }
                            })
                    } else {
                        registerRequest(userInfo)
                            .then(response => {
                                if (response.status === 201) {
                                    props.registerCallback()
                                }
                            })
                    }
                }}>{props.user ? 'Save' : 'Register'}</Button>
            </Row>
        </Form>
    )
}

export default UserEditComponent