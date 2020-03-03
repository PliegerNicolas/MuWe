import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox, map, setUserPosition } from '../plugins/init_mapbox';
// import { showLocation, errorHandler, getLocationUpdate } from '../plugins/current_user_position';
import { initCards } from '../plugins/cards';

initMapbox();
// getLocationUpdate();
setUserPosition();
initCards();
