import mapboxgl from 'mapbox-gl';
import { map } from '../plugins/mapbox'

const getUserUpdatedLocation = () => {
  if(navigator.geolocation) {

    let options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    };

    navigator.geolocation.watchPosition(userPosition, errorHandler, options);
  } else {
    alert("Sorry, your browser does not support geolocation !")
  }
}

const userPosition = (position) => {

  let pos = {
    lat: position.coords.latitude,
    lng: position.coords.longitude
  };

  let sPath = window.location.pathname;
  let sPage = sPath.substring(sPath.lastIndexOf('/') + 1);

  if(sPage == ""){ //This should be in mapbox to prevent the two imports and the duplication of this check (thus an error)
    new mapboxgl.Marker()
    .setLngLat([ pos.lng, pos.lat ])
    .addTo(map);
    map.flyTo({
      center: [ pos.lng, pos.lat ],
      zoom: 10,
      speed: 1.5
    });
  }
}

const errorHandler = (err) => {
  if(err.code == 1) {
    alert("Error: Access is denied!");
  } else if( err.code == 2) {
    alert("Error: Position is unavailable!");
  }
}

export { getUserUpdatedLocation, userPosition };
