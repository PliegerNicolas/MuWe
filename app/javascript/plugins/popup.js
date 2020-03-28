class HTMLPopup {
    constructor(marker) {
        this.marker = marker;
    }

    content() {
        return `<div class="popup-marker">
            <h3>${this.marker.title}</h3>
            <p class="description">${this.marker.description}</p>
            <p>Hosted by Sofia Mogas</p>
            <p>Status: ${this.marker.status}</p>
            <div class="date">
                <span>
                    <i class="far fa-calendar-alt"></i>${this.marker.start_date}
                </span>
                <span>
                    <i class="fas fa-hourglass-start"></i>22:00
                </span>
                <span>
                    <i class="fas fa-hourglass-end"></i>24:00
                </span>
            </div>
            <p><i class="fas fa-users"></i> ${this.marker.max_players}/${this.marker.max_players}</p>
            <p class="mt-2"><a href="/events/${this.marker.id}" target="_blank" class="btn btn-sm btn-muwe">See more</a></p>
        </div>`;
    }
}

export default HTMLPopup;