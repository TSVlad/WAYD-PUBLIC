import {connect} from "react-redux";
import UserDropDown from "./UserDropDown";
import {bindActionCreators} from "redux";
import {setUserAction} from "../../store/actionCreators/actionCreators";
import {Button, Image} from "react-bootstrap";
import ROLES from "../../utills/constants/roles";
import NotificationBellComponent from "./NotificationBellComponent";
import {useKeycloak} from "@react-keycloak/web";
import {useHistory} from "react-router-dom";

const NavbarWayd = (props) => {

    const {keycloak} = useKeycloak();
    const history = useHistory()


    return (
        <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
            <a href="/" className="navbar-brand">WA<b>YD</b></a>
            <button type="button" className="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                <span className="navbar-toggler-icon"/>
            </button>
            <div id="navbarCollapse" className="collapse navbar-collapse justify-content-start">
                <div className="navbar-nav">
                    <a href="/" className="nav-item nav-link">Home</a>
                    {props.user && props.user.realm_access.roles.includes(ROLES.USER) &&
                        <>
                            <a href={`/events/user/${props.user.sub}`} className="nav-item nav-link">Events</a>
                            <a href={`/users`} className="nav-item nav-link">Users</a>
                            <a href={`/subscribers`} className="nav-item nav-link">Subscribers</a>
                        </>
                    }
                    {props.user && props.user.realm_access.roles.includes(ROLES.PERSON) &&
                        <>
                            <a href={`/subscriptions`} className="nav-item nav-link">Subscriptions</a>
                            <a href={`/events/user/${props.user.sub}/participation`}
                               className="nav-item nav-link">Participation</a>
                        </>
                    }
                    {props.user && props.user.realm_access.roles.includes(ROLES.MODERATOR) &&
                        <>
                            <a href={'/moderation'} className="nav-item nav-link">Moderation</a>
                        </>
                    }
                    {props.user && props.user.realm_access.roles.includes(ROLES.ADMIN) &&
                        <>
                            <a href={'/categories'} className="nav-item nav-link">Categories</a>
                            <a href={'/ban-words'} className="nav-item nav-link">Ban words</a>
                            <a href={'/reasons'} className="nav-item nav-link">Reasons</a>
                        </>
                    }

                </div>
                <div className="navbar-nav ml-auto action-buttons">
                    {!props.user &&
                        <>
                            <span data-toggle="dropdown" className="nav-link dropdown-toggle mr-4"
                                  style={{cursor: 'pointer'}}
                                  onClick={() => keycloak.login()}>Login</span>
                            <a href={'/register'} className="btn btn-primary sign-up-btn"
                               onClick={() => history.push('/register')}>
                                Sign up
                            </a>
                        </>
                    }
                    {props.user && props.user.realm_access.roles.includes(ROLES.USER) &&
                        <a href="/event/new"><Button className="mr-3">Create event</Button></a>
                    }
                    {props.user &&
                        <>
                            <NotificationBellComponent/>
                            <UserDropDown/>
                        </>
                    }
                </div>
            </div>
        </nav>
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

export default connect(mapStateToProps, mapDispatchToProps)(NavbarWayd)