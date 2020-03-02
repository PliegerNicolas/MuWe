import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox, map } from '../plugins/init_mapbox';
import { showLocation, errorHandler, getLocationUpdate } from '../plugins/current_user_position';

initMapbox();
getLocationUpdate();

document.querySelectorAll('.small-card').forEach(function(card) {
    card.addEventListener('click', function(evt){
        map.flyTo({
            center: [
                card.dataset.lng,
                card.dataset.lat
            ],
            zoom: 10,
            speed: 1.5
        });
    });
});