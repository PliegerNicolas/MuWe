import {
    Controller
} from 'stimulus';
import bootstrap from 'bootstrap';

export default class extends Controller {
    static targets = [];

    connect(event) {
        console.log('events triggered');
    }

    join() {
        console.log('join event');
        $('#joinModal').modal();
    }

    setInstrument(event) {
        let hidden_instrument = $('#instrument_id');
        let joinBtn = $('#join-btn');
        let instrument_id = event.currentTarget.dataset.instrument;
        hidden_instrument.val(instrument_id);
        joinBtn.removeClass('disabled').attr('disabled', false);
    }
}