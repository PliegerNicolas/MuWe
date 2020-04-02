import {
    Controller
} from 'stimulus';
import Noty from 'noty';
import $ from 'jquery';
import 'select2';

export default class extends Controller {
    static targets = ['form', 'instrument', 'testing'];

    create_instrument_users(event) {
        let select = $(this.testingTarget).select2();
        let data = $(this.testingTarget).select2('data');
        let name = data[0].text;
        select.val(null).trigger('change');
        let t = new Noty({
            theme: 'relax',
            text: `You successfully added ${name} instrument.`,
            type: 'success',
            timeout: 1200
        }).show();
    }

    destroy_instrument_users(event) {
        let name = event.currentTarget.dataset.name;
        let t = new Noty({
            theme: 'relax',
            text: `You successfully removed ${name} instrument.`,
            type: 'success',
            timeout: 1200
        }).show();
    }
}