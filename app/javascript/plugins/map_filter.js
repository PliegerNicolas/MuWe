import {
  bouncedMarkers
} from '../plugins/mapbox';

const map_filter = () => {
  document.querySelector("#filter_button").addEventListener("click", function () {
    console.log("Filtering ...");
    bouncedMarkers();
  })
}

export {
  map_filter
};
