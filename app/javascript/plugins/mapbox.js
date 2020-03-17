import mapboxgl from 'mapbox-gl';
import { debounce } from 'lodash';
import axios from 'axios'

const fitMapToMarkers = (map, markers) => { // We'll have to replace markers by position of current_user
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
};

const initMap = () => {
  let map, initUserPos;
  let sPath = window.location.pathname;
  let sPage = sPath.substring(sPath.lastIndexOf('/') + 1);

  navigator.geolocation.getCurrentPosition(function (position) {
    initUserPos = {
      lat: position.coords.latitude,
      lng: position.coords.longitude
    }
    window.currentUserPosition = initUserPos; // Create console command to get user's position
    console.log("Current user\'s position :", initUserPos); // We've got the initial user position here

    if(sPage == '') {
      const mapElement = document.getElementById('map'); // Get info about map in HTML
      mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

      if (mapElement) { // Initalise first view of mapbox map
        map = new mapboxgl.Map({
          container: 'map',
          style: 'mapbox://styles/mapbox/streets-v10',
          center: [initUserPos.lng, initUserPos.lat],
          zoom: 11.89
        })
      }

      const geolocate = new mapboxgl.GeolocateControl({ // Geolocation settings
        positionOptions: {
          enableHighAccuracy: true
        },
        trackUserLocation: true,
        showAccuracyCircle: false
      });

      map.addControl(geolocate); // Start geolocating
      map.on('load', () => { // Trigger geolocation client side on load
        geolocate.trigger();
      })

      // Execute the rest => what happens with the markers

      const markers = JSON.parse(mapElement.dataset.markers);
      markers.forEach((marker) => {
        new mapboxgl.Marker()
          .setLngLat([ marker.lng, marker.lat ])
          .addTo(map);
      });
      fitMapToMarkers(map, markers);
    }
  });
}

export { initMap };
