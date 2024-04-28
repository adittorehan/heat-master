import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['menu'];

  toggle() {
    this.menuTarget.classList.toggle('hidden');
  }

  hide(event) {
    if (
      this.element.contains(event.target) === false
      && !this.menuTarget.classList.contains('hidden')
    ) {
      this.menuTarget.classList.add('hidden');
    }
  }
}
