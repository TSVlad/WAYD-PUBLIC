import {Image, NavDropdown} from "react-bootstrap";
import {connect} from "react-redux";
import {bindActionCreators} from "redux";
import {setUserAction} from "../../store/actionCreators/actionCreators";
import {useKeycloak} from "@react-keycloak/web";
import {deleteCookie} from "../../utills/cookies";
import LINKS from "../../utills/constants/links";
import {useEffect, useState} from "react";
import {getImageUrlByIdRequest} from "../../utills/request/requests/requests";
import {getUserByIdRequest} from "../../utills/request/requests/userRequests";
import {complainRequest} from "../../utills/request/requests/moderationRequest";
import ComplaintModalComponent from "../moderation/ComplaintModalComponent";

const UserDropDown = (props) => {

    const {keycloak, initialized} = useKeycloak();
    const [avatarUrl, setAvatarUrl] = useState(null)
    const [showComplaint, setShowComplaint] = useState(false)

    const onLogout = () => {
        deleteCookie('wayd-token')
        props.setUserDispatch(null)
        keycloak.logout({
            redirectUri: window.location.origin
        })
    }

    useEffect(() => {
        if (keycloak.authenticated) {
            getUserByIdRequest(keycloak.tokenParsed.sub)
                .then(response => {
                    if (response.status === 200) {
                        return response.json()
                    } else {
                        throw response
                    }
                })
                .then(user => {
                    return getImageUrlByIdRequest(user.avatar, true)
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
    }, [keycloak, initialized])

    return (
        <>
            <NavDropdown
                id="nav-dropdown-dark-example"
                title={<Image src={avatarUrl ? avatarUrl : LINKS.defaultAvatarLink}
                              className="avatar-small-circle"/>}
                menuVariant="dark"
            >
                <NavDropdown.Item href={`/user/${props.user.sub}`}>Profile</NavDropdown.Item>
                <NavDropdown.Item href={`/settings`}>Settings</NavDropdown.Item>
                <NavDropdown.Item onClick={() => setShowComplaint(true)}>Report problem</NavDropdown.Item>
                <NavDropdown.Divider/>
                <NavDropdown.Item onClick={onLogout}>Logout</NavDropdown.Item>
            </NavDropdown>

            <ComplaintModalComponent show={showComplaint} onHide={() => setShowComplaint(false)}
                                     onComplain={complaint => {
                                         complainRequest({...complaint, type: 'COMPLAINT_PROBLEM'})
                                         setShowComplaint(false)
                                     }}/>
        </>
    )

}

const mapStateToProps = (state) => {
    return {
        user: state.user
    }
}

const mapDispatchToProps = (dispatch) => {
    return bindActionCreators({
            setUserDispatch: setUserAction,
        },
        dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(UserDropDown)