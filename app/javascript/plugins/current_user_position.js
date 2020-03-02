let watchID;
let geoLocation;

function showLocation(position) {
  let latitude = position.coords.latitude;
  let longitude = position.coords.longitude;
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
    let options = {timeout:60000};
    geoLocation = navigator.geolocation;
    watchID = geoLocation.watchPosition(showLocation, errorHandler, options);
  } else {
    alert("Sorry, your browser does not support geolocation !")
  }
}

export { showLocation, errorHandler, getLocationUpdate }
