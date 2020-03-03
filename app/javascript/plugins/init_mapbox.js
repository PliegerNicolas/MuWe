import mapboxgl from 'mapbox-gl';

let map;
let watchID;
let geoLocation;
const mapElement = document.getElementById('map');

mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

const initMapbox = () => {

  if (mapElement) { // only build a map if there's a div#map to inject into
    map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    });
    const fitMapToMarkers = (map, markers) => { // We'll have to replace markers by position of current_user
      const bounds = new mapboxgl.LngLatBounds();
      markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
      map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 1500 });
    };

    if (mapElement) {
      // [ ... ]
      fitMapToMarkers(map, markers);
    }
  }
};

const setUserPosition = () => {
  if(navigator.geolocation) {
    let options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    };
    geoLocation = navigator.geolocation;
    watchID = geoLocation.watchPosition(showLocation, errorHandler, options);
  } else {
    alert("Sorry, your browser does not support geolocation !")
  }

}

const showLocation = (position) => {
  let latitude = position.coords.latitude;
  let longitude = position.coords.longitude;

  console.log(`Latitude = ${latitude}`);
  console.log(`Longitude = ${longitude}`);

  var elMarker = document.createElement('div');
  elMarker.className = 'user-marker';

  new mapboxgl.Marker(elMarker)
    .setLngLat([ longitude, latitude ])
    .addTo(map);

  map.flyTo({
      center: [
          longitude,
          latitude
      ],
      zoom: 12,
      speed: 1.5
  });
}

const errorHandler = (err) => {
  if(err.code == 1) {
    alert("Error: Access is denied!");
  } else if( err.code == 2) {
    alert("Error: Position is unavailable!");
  }
}

export { initMapbox, map, setUserPosition };
