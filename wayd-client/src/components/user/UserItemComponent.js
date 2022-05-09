import {Button, Image} from "react-bootstrap";
import {useEffect, useState} from "react";
import {subscribeRequest, unsubscribeRequest} from "../../utills/request/requests/notificationRequests";

const UserItemComponent = (props) => {
    const [subscribed, setSubscribed] = useState(props.subscribed)

    useEffect(() => {
        setSubscribed(props.subscribed)
    }, [props])

    return (
        <div className={props.className}>
            <a href={`/user/${props.user.id}`}>
                <Image src={props.imageUrl ? props.imageUrl : '/images/defaultAvatar.png'} style={{width: "15%"}}/>
                <div style={{display: "inline-block", width: "65%"}}>
                    <div className={'ml-2'}>
                        <h3>{props.user.surname} {props.user.name}</h3>
                        <h5>{props.user.username}</h5>
                    </div>
                </div>

            </a>
            <div style={{display: "inline-block", width: "20%"}}>
                {subscribed &&
                    <Button variant={'secondary'} onClick={() => {
                        unsubscribeRequest(props.user.id)
                            .then(response => {
                                if (response.status === 200) {
                                    setSubscribed(false)
                                } else {
                                    throw response
                                }
                            })
                    }
                    }>Unsubscribe</Button>
                }
                {!subscribed &&
                    <Button variant={'primary'} onClick={() => {
                        subscribeRequest(props.user.id)
                            .then(response => {
                                if (response.status === 200) {
                                    setSubscribed(true)
                                } else {
                                    throw response
                                }
                            })
                    }
                    }>Subscribe</Button>
                }
            </div>
        </div>
    )
}

export default UserItemComponent