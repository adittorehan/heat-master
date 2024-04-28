import { Controller } from 'stimulus';
import MicroModal from 'micromodal';

export default class extends Controller {
  connect() { // eslint-disable-line class-methods-use-this
    MicroModal.init();
  }
}
