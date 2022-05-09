import {MapContainer, TileLayer} from 'react-leaflet'
import {connect} from "react-redux";
import 'leaflet/dist/leaflet.css';
import icon from 'leaflet/dist/images/marker-icon.png';
import L from 'leaflet'
import CustomMapComponents from "./CustomMapComponents";

const MapWayd = (props) => {

    /*let DefaultIcon = L.icon({
        iconUrl: icon,
        iconSize: [24, 40],
        iconAnchor: [12, 40]
    });
    L.Marker.prototype.options.icon = DefaultIcon;*/

    return (
        <div className={'wayd-map-container'}>
            <MapContainer center={[59.57, 30.19]} zoom={13} scrollWheelZoom={true} id={'wayd-map'} doubleClickZoom={false}>
                <TileLayer
                    attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                    url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                />

                <CustomMapComponents/>

            </MapContainer>
        </div>
    )
}

const mapStateToProps = (state) => {
    return {
        showUnsuccessfulLoginAlert: state.showUnsuccessfulLoginAlert
    }
}


export default connect(mapStateToProps)(MapWayd)