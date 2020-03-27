import "bootstrap";
import Swiper from 'swiper';

import {
    initMap
} from '../plugins/mapbox';

import {
    initCards
} from '../plugins/cards';

import {
    initSelect2
} from '../plugins/init_select2';

import "../plugins/flatpickr"

import {
    addressAutocomplete
} from "../plugins/address_autocomplete";

import {
    readURL
} from '../plugins/file_upload';


initCards();
initSelect2();

$('.select2').select2({
    width: '100%'
});
addressAutocomplete();

// readURL();

initMap();
window.initMap = initMap;

let mapSwiper = new Swiper('.swiper-container', {
    direction: 'horizontal',
    slidesPerView: 'auto',
    grabCursor: true,
    freeMode: true,
    scrollbar: {
        el: '.swiper-scrollbar',
        hide: false,
    },
    navigation: {
        prevEl: '.swiper-button-prev',
        nextEl: '.swiper-button-next',
    }
});

const filterBtn = document.querySelector('.btn-filter');
const filterBtnClose = document.querySelector('.btn-filter-close');
const filterWrapper = document.querySelector('.filter-wrapper');
filterBtn.addEventListener('click', () => {
    filterWrapper.classList.toggle('open');
});
filterBtnClose.addEventListener('click', () => {
    filterWrapper.classList.toggle('open');
});
