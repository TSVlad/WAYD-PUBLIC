import {useMap} from "react-leaflet";
import {useEffect} from "react";

const ChangeViewComponent = (props) => {
    const map = useMap()

    useEffect(() => {
        if (props.center) {
            map.setView(props.center, map.getZoom())
        }
    }, [props.center, map])

    return null
}

export default ChangeViewComponent