import {MapContainer, Marker, TileLayer} from "react-leaflet";
import LocationMarker from "./markers/LocationMarker";
import SelectPlaceMarker from "./markers/SelectPlaceMarker";
import icon from 'leaflet/dist/images/marker-icon.png';
import L from 'leaflet'
import ChangeViewComponent from "./ChangeViewComponent";

const SmallMapComponent = (props) => {

    let DefaultIcon = L.icon({
        iconUrl: icon,
        iconSize: [24, 40],
        iconAnchor: [12, 40]
    });
    L.Marker.prototype.options.icon = DefaultIcon;

    console.log('MARKER')
    console.log(props.markerPosition)

    return (
        <div>
            <MapContainer center={[59.57, 30.19]} zoom={13} scrollWheelZoom={true} id={'wayd-small-map'}>
                <TileLayer
                    attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                    url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                />
                <ChangeViewComponent center={props.markerPosition ? props.markerPosition : null}/>
                <LocationMarker startByDefault={!props.markerPosition}/>
                {props.editMode && (
                    <SelectPlaceMarker position={props.markerPosition} onMarkerSet={props.onMarkerSet}/>
                )}
                {props.markerPosition && !props.editMode && (
                    <Marker position={props.markerPosition}/>
                )}
            </MapContainer>
        </div>
    )
}

export default SmallMapComponent