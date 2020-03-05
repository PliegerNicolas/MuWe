import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/mapbox'
import { getUserUpdatedLocation } from '../plugins/user_position_handler';
import { initCards } from '../plugins/cards';

initMapbox();
initCards();
getUserUpdatedLocation();
