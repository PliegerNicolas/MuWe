import { map } from '../plugins/init_mapbox';

let watchID;
let geoLocation;

function showLocation(position) {
  let latitude = position.coords.latitude;
  let longitude = position.coords.longitude;
  console.log(`Latitude = ${latitude}`);
  console.log(`Longitude = ${longitude}`);
  new mapboxgl.Marker()
  .setLngLat([ longitude, latitude ])
  .addTo(map);
  map.flyTo({
      center: [
          longitude,
          latitude
      ],
      zoom: 10,
      speed: 1.5
  });

}

function errorHandler(err) {
  if(err.code == 1) {
    alert("Error: Access is denied!");
  } else if( err.code == 2) {
    alert("Error: Position is unavailable!");
  }
}

function getLocationUpdate() {
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

export { showLocation, errorHandler, getLocationUpdate }
