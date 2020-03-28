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

import {
  map_filter, city_filter
} from '../plugins/map_filter';

initCards();
initSelect2();

$('.select2').select2({
    width: '100%'
});
addressAutocomplete();

// readURL();

initMap();
window.initMap = initMap;
map_filter();
city_filter();

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

if (filterWrapper) {
  filterBtn.addEventListener('click', () => {
      filterWrapper.classList.toggle('open');
  });
}

if (filterBtnClose) {
  filterBtnClose.addEventListener('click', () => {
      filterWrapper.classList.toggle('open');
  });
}

const navbar = document.querySelector('.navbar-container');
window.addEventListener('scroll', (e) => {
    const offset = navbar.offsetTop;
    if (window.pageYOffset > offset) {
        navbar.classList.add('fixed');
    } else {
        navbar.classList.remove('fixed');
    }
});


const aboutButton = document.querySelector('.about-btn');
if (aboutButton) {
  aboutButton.addEventListener('click', (event) => {
    document.querySelector('#chat').style.display = "none";
    document.querySelector('.players-card').style.display = "initial";
    event.target.classList.toggle('active');
    document.querySelector('.chat-btn').classList.toggle('active');
  });
}

const chatButton = document.querySelector('.chat-btn');
if (chatButton) {
  chatButton.addEventListener('click', () => {
    document.querySelector('#chat').style.display = "initial";
    document.querySelector('.players-card').style.display = "none";
    event.target.classList.toggle('active');
    document.querySelector('.about-btn').classList.toggle('active');
  });
}
