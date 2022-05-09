import {Marker} from "react-leaflet";
import MarkerClusterGroup from "react-leaflet-markercluster";
import 'react-leaflet-markercluster/dist/styles.min.css';
import {getMarkerIconForEvent} from "./EventMarkerIcons";

const EventMarkers = (props) => {

    return (
        <MarkerClusterGroup key={props.clusterKey}>
            {props.events.map(event => (
                <Marker key={event.id} position={[event.point.x, event.point.y]} icon={getMarkerIconForEvent(event)} eventHandlers={{
                    click: () => {
                        props.onMarkerSelect(event)
                    }
                }}>
                </Marker>
            ))}
        </MarkerClusterGroup>
    )
}

export default EventMarkers