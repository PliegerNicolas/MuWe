import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/mapbox'
import { initCards } from '../plugins/cards';
import { initSelect2 } from '../plugins/init_select2';
import "../plugins/flatpickr"
import { addressAutocomplete } from "../plugins/address_autocomplete";
import { readURL } from '../plugins/file_upload';


initSelect2();
initMapbox();
initCards()

$('.select2').select2({ width: '100%' });

addressAutocomplete();
readURL();
