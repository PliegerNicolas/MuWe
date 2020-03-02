import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';
import { showLocation, errorHandler, getLocationUpdate } from '../plugins/current_user_position';
initMapbox();
getLocationUpdate();
