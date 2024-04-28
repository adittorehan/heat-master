import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['source', 'tooltip'];

  copy() {
    this.sourceTarget.select();
    this.sourceTarget.setSelectionRange(0, 99999);

    document.execCommand('copy');
    this.tooltipTarget.classList.remove('hidden');
  }

  hide(event) {
    if (
      this.element.contains(event.target) === false
      && !this.tooltipTarget.classList.contains('hidden')
    ) {
      this.tooltipTarget.classList.add('hidden');
    }
  }
}
