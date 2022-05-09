import './App.css';
import {BrowserRouter as Router, Route, Switch,} from "react-router-dom";
import Home from "./components/pages/Home";
import NavbarWayd from "./components/navbar/NavbarWayd";
import Categories from "./components/pages/Categories";
import EventPage from "./components/pages/EventPage";
import NewEventPage from "./components/pages/NewEventPage";
import UsersEventsPage from "./components/pages/UsersEventsPage";
import UserParticipationPage from "./components/pages/UserParticipationPage";
import NotificationsPage from "./components/pages/NotificationsPage";
import {ReactKeycloakProvider} from "@react-keycloak/web";
import {keycloak} from "./components/security/KeycloakSettings";
import {useEffect} from "react";
import {deleteCookie, getCookie, setCookie} from "./utills/cookies";
import {bindActionCreators} from "redux";
import {setUserAction} from "./store/actionCreators/actionCreators";
import {connect} from "react-redux";
import SettingsPage from "./components/pages/SettingsPage";
import UserProfilePage from "./components/pages/UserProfilePage";
import RegisterPage from "./components/pages/RegisterPage";
import SubscriptionsPage from "./components/pages/SubscriptionsPage";
import SubscribersPage from "./components/pages/SubscribersPage";
import UsersPage from "./components/pages/UsersPage";
import BanWordsPage from "./components/pages/BanWordsPage";
import ModerationPage from "./components/pages/ModerationPage";
import ReasonsPage from "./components/pages/ReasonsPage";
import OrganizationRegistrationPage from "./components/moderation/OrganizationRegistrationPage";

function App(props) {

    console.log(process.env.KEYCLOAK_ADDRESS)

    useEffect(() => {
        const token = getCookie('wayd-token')
        if (token) {
            const tokenArray = token.split('.')
            const payload = JSON.parse(atob(tokenArray[1]))
            if (!props.user) {
                props.setUserDispatch(payload)
            }
        }
    }, [props])

    return (
        <ReactKeycloakProvider authClient={keycloak} initOptions={{onLoad: 'check-sso',
            silentCheckSsoRedirectUri:  window.location.origin + '/silent-check-sso.html'}}
                               onTokens={(tokens) => {
                                   if (tokens.token) {
                                       setCookie('wayd-token', tokens.token)
                                       props.setUserDispatch(keycloak.tokenParsed)
                                   } else {
                                       deleteCookie('wayd-token')
                                       props.setUserDispatch(null)
                                   }
                               }}>

            <Router>
                <div className="App">
                    <NavbarWayd/>
                    <Switch>
                        <Route path={"/notifications"}>
                            <NotificationsPage/>
                        </Route>
                        <Route path="/categories">
                            <Categories/>
                        </Route>
                        <Route path="/ban-words">
                            <BanWordsPage/>
                        </Route>
                        <Route path={'/subscriptions'}>
                            <SubscriptionsPage/>
                        </Route>
                        <Route path={'/subscribers'}>
                            <SubscribersPage/>
                        </Route>
                        <Route path={'/users'}>
                            <UsersPage/>
                        </Route>
                        <Route path="/user/:userId/edit">
                            <UserProfilePage editMode={true}/>
                        </Route>
                        <Route path="/user/:userId">
                            <UserProfilePage/>
                        </Route>
                        <Route path={"/events/user/:userId/participation"}>
                            <UserParticipationPage/>
                        </Route>
                        <Route path={"/settings"}>
                            <SettingsPage/>
                        </Route>
                        <Route path={"/events/user/:userId"}>
                            <UsersEventsPage/>
                        </Route>
                        <Route path={"/event/new"}>
                            <NewEventPage/>
                        </Route>
                        <Route path={"/event/edit/:eventId"}>
                            <EventPage edit={true}/>
                        </Route>
                        <Route path={"/event/:eventId"}>
                            <EventPage/>
                        </Route>
                        <Route path={"/register"}>
                            <RegisterPage/>
                        </Route>
                        <Route path={'/moderation'}>
                            <ModerationPage/>
                        </Route>
                        <Route path={'/reasons'}>
                            <ReasonsPage/>
                        </Route>
                        <Route path={'/organization/register'}>
                            <OrganizationRegistrationPage/>
                        </Route>
                        <Route path="/">
                            <Home/>
                        </Route>
                    </Switch>
                </div>
            </Router>

        </ReactKeycloakProvider>
    );
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

export default connect(mapStateToProps, mapDispatchToProps)(App);
