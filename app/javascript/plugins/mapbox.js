import mapboxgl from 'mapbox-gl';
import {
  debounce
} from 'lodash';
import axios from 'axios'
import HTMLPopup from './popup';

let map, initUserPos;
let mapElement;
let eventsWrapper = document.getElementById('events-wrapper');

const saveLocation = (initUserPos) => { // Save user pos temp
  // console.log(initUserPos)
  const request = axios.get('/location', {
    params: {
      init_user_pos: [initUserPos.lat, initUserPos.lng]
    }
  });
}

const fitBound = () => {
  let latitudes = events.filter(event => {
    return event.latitude
  });
  let longitudes = events.filter(event => event.longitude);
  // console.log(latitudes);
  // console.log(longitudes);
};

const fitMapToMarkers = (map, markers) => { // We'll have to replace markers by position of current_user
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
  map.fitBounds(bounds, {
    padding: 70,
    maxZoom: 15,
    duration: 1500
  });
};

const fetchMarkers = async () => {
  const pos = map.getCenter();
  const {
    _sw,
    _ne
  } = map.getBounds();

  const res = await axios.get('/search', {
    params: {
      latitude: pos.lat,
      longitude: pos.lng,
      max_lat: _ne.lat,
      min_lat: _sw.lat,
      max_lng: _ne.lng,
      min_lng: _sw.lng,
      periode: document.querySelector("#filter_periode").value,
      start_time: document.querySelector("#filter_start_time").value,
      end_time: document.querySelector("#filter_end_time").value,
      max_players: document.querySelector("#filter_max_players").value,
      status: document.querySelector("#filter_status").value
    }
  });
  return {
    events: res.data.events,
    cards: res.data.cards,
    posts: res.data.posts
  }
}

const clearMarkers = () => {
  // this querySelectorAll is to generic and also gets the userposition marker
  // maybe a custom className could be added to marker before addTo(map)
  const markers = mapElement.querySelectorAll('.mapboxgl-marker');
  markers.forEach((marker) => {
    marker.remove();
  })
}

const bouncedMarkers = debounce(() => {
  fetchMarkers()
    .then((response) => {
      const {
        events,
        cards,
        posts
      } = response;

      clearMarkers();
      let markersLoaded = {}

      eventsWrapper.innerHTML = cards;
      // Add posts here !!!!!!

      events.forEach((marker) => {
        let htmlPopup = new HTMLPopup(marker);

        let popup = new mapboxgl.Popup({
          // offset: 25,
          maxWidth: 'max-content'
        }).setHTML(
          htmlPopup.content()
        );

        let color = (marker.status == 'planned') ? '#44AEE6' : '#6BB382';

        let el = new mapboxgl.Marker({
            color
          })
          .setLngLat([marker.longitude, marker.latitude])
          .setPopup(popup)
          .addTo(map);

        // keep a dictionnary of the markers
        markersLoaded[marker.id] = {
          'lng': marker.longitude,
          'lat': marker.latitude,
          el
        }
      });
      // console.log(markersLoaded);

      // get all the cards loaded in .swiper-wrapper
      const cardsLoaded = document.querySelectorAll('.swiper-wrapper > div');
      cardsLoaded.forEach(el => {
        el.addEventListener('click', (e) => {
          // close all popup that are eventually open
          mapElement.querySelectorAll('.mapboxgl-popup').forEach(popup => {
            popup.remove();
          });

          map.flyTo({
            center: [markersLoaded[el.dataset.event]['lng'], markersLoaded[el.dataset.event]['lat']],
            zoom: 10,
          });
          markersLoaded[el.dataset.event].el.togglePopup();
        });
      });
    });
}, 400);

const initMap = () => {
  mapElement = document.getElementById('map'); // Get info about map in HTML

  if (mapElement) { // Initalise first view of mapbox map
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10',
      center: [-7.8536599, 39.557191],
      zoom: 7
    })

    const geolocate = new mapboxgl.GeolocateControl({ // Geolocation settings
      positionOptions: {
        enableHighAccuracy: true
      },
      trackUserLocation: true,
      showAccuracyCircle: false,
    });

    map.addControl(geolocate); // Start geolocating
    map.on('load', () => { // Trigger geolocation client side on load
      geolocate.trigger();
    })

    map.on('render', () => {
      // console.log(map.getBounds());
      bouncedMarkers();
    });
  }

  /*
  let sPath = window.location.pathname;
  let sPage = sPath.substring(sPath.lastIndexOf('/') + 1);

  navigator.geolocation.getCurrentPosition(function (position) {
      initUserPos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      }

      saveLocation(initUserPos);
      console.log("initial user\'s position :", initUserPos); // We've got the initial user position here

      if (sPage == '') {
        mapElement = document.getElementById('map'); // Get info about map in HTML
        mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

        if (mapElement) { // Initalise first view of mapbox map
          map = new mapboxgl.Map({
            container: 'map',
            style: 'mapbox://styles/mapbox/streets-v10',
            center: [initUserPos.lng, initUserPos.lat],
            zoom: 11
          })
        }

        const geolocate = new mapboxgl.GeolocateControl({ // Geolocation settings
          positionOptions: {
            enableHighAccuracy: true
          },
          trackUserLocation: true,
          showAccuracyCircle: false,
        });

        map.addControl(geolocate); // Start geolocating
        map.on('load', () => { // Trigger geolocation client side on load
          geolocate.trigger();
        })

        // Execute the rest => what happens with the markers

        map.on('render', () => {
          // console.log(map.getBounds());
          bouncedMarkers();
        });
      }
    },
    function (error) { // Fallback method if localisation refused by user
      if (error.code == error.PERMISSION_DENIED)
        if (sPage == '') {
          mapElement = document.getElementById('map'); // Get info about map in HTML
          mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

          if (mapElement) { // Initalise first view of mapbox map
            map = new mapboxgl.Map({
              container: 'map',
              style: 'mapbox://styles/mapbox/streets-v10',
              center: [-90.048981, 35.149532],
              zoom: 11
            })

            map.on('render', () => {
              // console.log(map.getBounds());
              bouncedMarkers();
            });
          }
        }
    }
  );
  */
}

export {
  initMap,
  bouncedMarkers,
  map
};