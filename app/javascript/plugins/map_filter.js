import {
  bouncedMarkers
} from '../plugins/mapbox';

const map_filter = () => {
  document.querySelector("#filter_button").addEventListener("click", function () {
    bouncedMarkers();
    console.log("Filtering ...");
  })
}

export {
  map_filter
};