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

const callPosition = () => {
  setTimeout(() => {
    // console.log(position)
    axios.get('/nearby', {
      params: {
        latitude: position.latitude,
        longitude: position.longitude
      }
    }).then((res) => {
      events = res.data.events;
      console.log('nuno');
    }).then(() => {
      console.log('martins');
      // fitBound();
    });
  }, 15000);
}

const fitMapToMarkers = (map, markers) => { // We'll have to replace markers by position of current_user
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 1500 });
};

const fetchMarkers = () => {
  console.log('getting new markers');
}

const initMapbox = () => {

  let sPath = window.location.pathname;
  let sPage = sPath.substring(sPath.lastIndexOf('/') + 1);

  if(sPage == "") {

    const mapElement = document.getElementById('map');
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    if (mapElement) { // only build a map if there's a div#map to inject into
      map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v10'
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
          callPosition();
        });


      });

      map.on('render', () => {
        fetchMarkers();
      });

      // fitMapToMarkers(map, markers);
    }
  }
};



export { initMapbox, map };
