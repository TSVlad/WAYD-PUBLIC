import {useEffect, useState} from "react";
import {useMap} from "react-leaflet";
import L from 'leaflet'
import 'leaflet.locatecontrol'

const LocationMarker = (props) => {
    const [locationControl, setLocationControl] = useState(null)
    const map = useMap();

    useEffect(() => {

        if (!locationControl) {
            const lc = L.control.locate().addTo(map)
            if (props.startByDefault) {
                lc.start()
            }
            setLocationControl(lc)
        } else {
            if (!props.startByDefault) {
                locationControl.stop()
            }
        }
    }, [map, locationControl, props.startByDefault]);

    return null
}

export default LocationMarker;