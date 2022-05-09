import {Card} from "react-bootstrap";
import {isoToLocalDateTimeForShow} from "../../../utills/dates";
import LINKS from "../../../utills/constants/links";
// import '../../../index.css'

const EventCardComponent = (props) => {
    return (
        <div className={'text-left'}>
            <a href={`/event/${props.event.id}`} >

            <Card style={{ width: '14rem'}} className={'m-3'}>

                <Card.Img  variant="left" src={props.imageUrl ? props.imageUrl : LINKS.defaultEventImageLink} />
                <Card.Body>
                    <Card.Title href={`/event/${props.event.id}`} >{props.event.name}</Card.Title>
                    <Card.Text>
                        {isoToLocalDateTimeForShow(props.event.dateTime)}
                    </Card.Text>
                </Card.Body>
            </Card>

            </a>
        </div>
    )
}

export default EventCardComponent