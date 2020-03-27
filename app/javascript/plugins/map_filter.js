import {
    initMap
} from '../plugins/mapbox';

const map_filter = () => {
  document.querySelector("#filter_button").addEventListener("click", function(){
    initMap();
    console.log("Filtering ...");
  })
}

export { map_filter };
