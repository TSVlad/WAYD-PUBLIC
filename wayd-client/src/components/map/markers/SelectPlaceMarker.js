import {Marker, useMapEvents} from "react-leaflet";
import {useState} from "react";
import 'react-leaflet-markercluster/dist/styles.min.css';

const SelectPlaceMarker = (props) => {
    // const [point, setPoint] = useState(null)

    const setMarkerByClickEvent = (event) => {
        // setPoint(event.latlng)
        props.onMarkerSet(event.latlng)
    }

    useMapEvents({
        click: setMarkerByClickEvent
    });

    return (
        <>
            {props.position &&
            <Marker position={props.position}/>
            }
        </>
    )
}

export default SelectPlaceMarker