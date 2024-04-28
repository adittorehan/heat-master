import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['block', 'icon', 'buttonText'];

  toggle() {
    this.blockTarget.classList.toggle('hidden');
    this.iconTargets.forEach((elem) => elem.classList.toggle('hidden'));
    this.buttonTextTarget.innerHTML = this.blockTarget.classList.contains('hidden') ? 'Show more' : 'Show less';
  }
}
