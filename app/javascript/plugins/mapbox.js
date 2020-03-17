import mapboxgl from 'mapbox-gl';
import { debounce } from 'lodash';
import axios from 'axios'

let map;




const fitBound = () => {
  let latitudes = events.filter(event => {
    // console.log(event.longitude);
    // console.log(event.latitude);
    return event.latitude
  });
  let longitudes = events.filter(event => event.longitude);
  console.log(latitudes);
  console.log(longitudes);
};

const fitMapToMarkers = (map, markers) => { // We'll have to replace markers by position of current_user
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 1500 });
};

const fetchMarkers =  async () => {
  const pos = map.getCenter();
  const res = await axios.get('/search', {
    params: {
      latitude: pos.lat,
      longitude: pos.lng
    }
  });
  return res.data.events;
}

const bouncedMarkers = debounce(() => {
  fetchMarkers()
    .then((response) => {
      response.forEach((marker) => {
        // console.log(marker);

        let popup = new mapboxgl.Popup({ offset: 25, maxWidth: '320px' }).setHTML(
          `<div class="popup-marker">
            <h3>${marker.title}</h3>
            <p>${marker.description}</p>
            <p>Players: ${marker.max_players} | Status: ${marker.status}</p>
          </div>`
        );

        let color = (marker.status == 'planned') ? '#44AEE6' : '#6BB382';

        new mapboxgl.Marker({color})
          .setLngLat([ marker.longitude, marker.latitude ])
          .setPopup(popup)
          .addTo(map);
      });
    });
}, 1000);





const initMap = () => {
  let initUserPos, mapCenter;
  let sPath = window.location.pathname;
  let sPage = sPath.substring(sPath.lastIndexOf('/') + 1);

  navigator.geolocation.getCurrentPosition(function (position) {
    initUserPos = {
      lat: position.coords.latitude,
      lng: position.coords.longitude
    }
    console.log("initial user\'s position :", initUserPos); // We've got the initial user position here

    if(sPage == '') {
      const mapElement = document.getElementById('map'); // Get info about map in HTML
      mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

      if (mapElement) { // Initalise first view of mapbox map
        map = new mapboxgl.Map({
          container: 'map',
          style: 'mapbox://styles/mapbox/streets-v10',
          center: [initUserPos.lng, initUserPos.lat],
          zoom: 11
        })
      }

      const geolocate = new mapboxgl.GeolocateControl({ // Geolocation settings
        positionOptions: {
          enableHighAccuracy: true
        },
        trackUserLocation: true,
        showAccuracyCircle: false,
      });

      map.addControl(geolocate); // Start geolocating
      map.on('load', () => { // Trigger geolocation client side on load
        geolocate.trigger();
      })

      // Execute the rest => what happens with the markers

      map.on('render', () => {
        bouncedMarkers();
      });
    }
  });
}

export { initMap };
