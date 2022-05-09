import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import {Provider} from "react-redux";
import store from "./store/store";
import 'bootstrap/dist/css/bootstrap.min.css'
// import 'leaflet/dist/leaflet.css'
import './css/map.css'
import * as PropTypes from "prop-types";

function ReactKeycloakProvider(props) {
    return null;
}

ReactKeycloakProvider.propTypes = {
    initOptions: PropTypes.shape({silentCheckSsoRedirectUri: PropTypes.string, onLoad: PropTypes.string}),
    onTokens: PropTypes.func,
    authClient: PropTypes.any,
    children: PropTypes.node
};


ReactDOM.render(
  <React.StrictMode>
      <Provider store={store}>
            <App />
      </Provider>
  </React.StrictMode>,
  document.getElementById('root')
);
