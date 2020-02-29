import "bootstrap";
import mapboxgl from 'mapbox-gl';

mapboxgl.accessToken = 'pk.eyJ1IjoiYWx2ZXNtYXJ0aW5zIiwiYSI6ImNrNHprcjZ3ZzBiYzQzam9kYmNmcm9yd2wifQ.5NITBJndEqiHl2Vm8tVPDg';
const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v9',
    center: [-9.142685,38.736946],
    zoom: 13
});