import { debounce } from 'lodash';
import axios from 'axios'
import mapboxgl from 'mapbox-gl';

let map;
let position = null;
let events;

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

const initMapbox = () => {

  let sPath = window.location.pathname;
  let sPage = sPath.substring(sPath.lastIndexOf('/') + 1);

  if(sPage == "") {

    const mapElement = document.getElementById('map');
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    if (mapElement) { // only build a map if there's a div#map to inject into
      map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v10',
        center: [-9.142685, 38.736946], // hard code lng & lat from Lisbon
        zoom: 9 // starting zoom
      });

      // const markers = JSON.parse(mapElement.dataset.markers);
      // markers.forEach((marker) => {
      //   new mapboxgl.Marker()
      //     .setLngLat([ marker.lng, marker.lat ])
      //     .addTo(map);
      // });


      const geolocate = new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true
        },
        trackUserLocation: true,
        showAccuracyCircle: false
      });
      map.addControl(geolocate);

      map.on('load', () => {

        // const events = getEventsNear(geolocate).then((res) => {
        //   console.log(res);
        // });
        geolocate.trigger();

        geolocate.on('geolocate', (pos) => {
          console.log(pos.coords.latitude);
          console.log(pos.coords.longitude);
          position = pos.coords;
        });
      });


      map.on('render', () => {
        bouncedMarkers();
      });

      // fitMapToMarkers(map, markers);
    }
  }
};

export { initMapbox, map };
