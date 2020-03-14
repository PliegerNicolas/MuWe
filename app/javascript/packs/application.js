import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/mapbox'
import { initCards } from '../plugins/cards';
import { initSelect2 } from '../plugins/init_select2';
import "../plugins/flatpickr"


initSelect2();
initMapbox();
initCards();

$('.select2').select2({ width: '100%' });
