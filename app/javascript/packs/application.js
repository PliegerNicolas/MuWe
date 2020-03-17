import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import Swiper from 'swiper';

import { initMapbox } from '../plugins/mapbox'
import { initCards } from '../plugins/cards';
import { initSelect2 } from '../plugins/init_select2';
import "../plugins/flatpickr"
import { addressAutocomplete } from "../plugins/address_autocomplete";


initSelect2();
initMapbox();
window.initMapbox = initMapbox;
initCards();

$('.select2').select2({ width: '100%' });
addressAutocomplete();

let mapSwiper = new Swiper('.swiper-container', {
    direction: 'horizontal',
    slidesPerView: 'auto',
    grabCursor: true,
    freeMode: true,
    scrollbar: {
        el: '.swiper-scrollbar',
        hide: true
    },
    navigation: {
        prevEl: '.swiper-button-prev',
        nextEl: '.swiper-button-next'
    }
});
