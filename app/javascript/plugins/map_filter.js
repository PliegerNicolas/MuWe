import {
  bouncedMarkers, map
} from '../plugins/mapbox';

import axios from 'axios'

const map_filter = () => {
  document.querySelector("#filter_button").addEventListener("click", function () {
    console.log("Filtering ...");
    bouncedMarkers();
  })
}

const city_filter = () => {
  document.querySelector("#filter_button").addEventListener("click", function () {
    console.log("Filtering ...");

    const pos = map.getCenter();
    const { _sw, _ne } = map.getBounds();

    const res = axios.get('/search', {
      params: {
        latitude: pos.lat,
        longitude: pos.lng,
        max_lat: _ne.lat,
        min_lat: _sw.lat,
        max_lng: _ne.lng,
        min_lng: _sw.lng,
        city: document.querySelector("#filter_city").value,
        periode: document.querySelector("#filter_periode").value,
        start_time: document.querySelector("#filter_start_time").value,
        end_time: document.querySelector("#filter_end_time").value,
        max_players: document.querySelector("#filter_max_players").value,
        status: document.querySelector("#filter_status").value
      }
    });
    return {
      events: res.data.events,
      cards: res.data.cards,
      city_coords: res.data.city_coords,
      map_box_limit: res.data.map_box_limit
    }
  })
}

const flyToCity = (city_coords, map_box_limit) => {
  if (!(map_box_limit[0] > city_coords[0] && map_box_limit[1] < city_coords[0] && map_box_limit[2] > city_coords[1] && map_box_limit[3] < city_coords[1])) {
    map.flyTo({
      center: [city_coords[1], city_coords[0]],
      essential: true
    });
  }
}

export {
  map_filter, city_filter
};
