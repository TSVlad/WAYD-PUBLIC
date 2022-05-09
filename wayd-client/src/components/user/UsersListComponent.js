import UserItemComponent from "./UserItemComponent";
import {useEffect, useState} from "react";
import {getSubscriptionsRequest} from "../../utills/request/requests/notificationRequests";
import {useKeycloak} from "@react-keycloak/web";

const UsersListComponent = (props) => {
    const [subscriptions, setSubscriptions] = useState([])

    const {initialized} = useKeycloak()

    useEffect(() => {
        if (initialized) {
            if (!props.subscriptions) {
                getSubscriptionsRequest()
                    .then(response => {
                        if (response.status === 200) {
                            return response.json()
                        } else {
                            throw response
                        }
                    })
                    .then(subs => {
                        setSubscriptions(subs)
                    })
            } else {
                setSubscriptions(props.subscriptions)
            }
        }
    }, [props, initialized])

    return (
        <div className={props.className} style={props.style}>
            {props.users.map(user => (
                <UserItemComponent key={user.id} user={user} className={'mt-3'}
                                   imageUrl={props.images[user.avatar]} subscribed={subscriptions.includes(user.id)}/>
            ))}
        </div>
    )
}

export default UsersListComponent