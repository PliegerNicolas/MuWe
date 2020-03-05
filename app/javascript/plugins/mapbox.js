import mapboxgl from 'mapbox-gl';

let map;

const initMapbox = () => {

  let sPath = window.location.pathname;
  let sPage = sPath.substring(sPath.lastIndexOf('/') + 1);

  if(sPage == ""){

    const mapElement = document.getElementById('map');
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

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
  }
};

export { initMapbox, map };

