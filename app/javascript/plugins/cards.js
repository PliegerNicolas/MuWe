import {
    map
} from '../plugins/mapbox';

const initCards = () => {
    document.querySelectorAll('.small-card').forEach(function (card) {
        card.addEventListener('click', function (evt) {
            map.flyTo({
                center: [
                    card.dataset.lng,
                    card.dataset.lat
                ],
                zoom: 10,
                speed: 1.5
            });
        });
    });
}

export {
    initCards
}