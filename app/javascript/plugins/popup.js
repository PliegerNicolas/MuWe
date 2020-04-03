class HTMLPopup {
    constructor(marker) {
        this.marker = marker;
        console.log(marker);
    }

    content() {
        return `<div class="popup-marker">
            <h3>${this.marker.title}</h3>
            <p class="description">${this.marker.description}</p>
            <p>Hosted by <a href="/profiles/${this.marker.user.id}" target="_blank">${this.marker.user.first_name}</a></p>
            <p>Status: ${this.marker.status}</p>
            <p>Music style: ${this.marker.music_style.style}</p>
            <div class="date">
                <div>
                    <i class="far fa-calendar-alt"></i> <span>${this.marker.start_date}</span>
                </div>
                <div>
                    <i class="fas fa-hourglass-start"></i> <span>22:00</span>
                </div>
                <div>
                    <i class="fas fa-hourglass-end"></i> <span>24:00</span>
                </div>
            </div>
            <p class="mt-2"><a href="/events/${this.marker.id}" target="_blank" class="btn btn-sm btn-muwe">See more</a></p>
        </div>`;
    }
}

export default HTMLPopup;