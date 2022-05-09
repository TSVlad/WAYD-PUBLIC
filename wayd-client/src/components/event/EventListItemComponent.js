import {Image} from "react-bootstrap";
import '../../css/links.css'
import {isoToLocalDateTimeForShow} from "../../utills/dates";

const EventListItemComponent = (props) => {
    return (
        <div className={props.className}>
            <a href={`/event/${props.event.id}`}>
                <Image src={props.imageUrl ? props.imageUrl : '/images/defaultEventImage.png'} style={{width: "30%"}}/>
                <div style={{display: "inline-block", width: "70%"}}>
                    <div className={'ml-2'}>
                        <h3>{props.event.name}</h3>
                        <h5>{isoToLocalDateTimeForShow(props.event.dateTime)}</h5>
                    </div>
                </div>
            </a>
        </div>
    )
}

export default EventListItemComponent