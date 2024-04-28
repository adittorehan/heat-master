import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['cell'];

  connect() {
    this.cellTargets.forEach((cell) => {
      const value = cell.textContent;
      if (value < 1) {
        cell.classList.add('bg-orange-200');
      } else if (value < 2) {
        cell.classList.add('bg-orange-300');
      } else if (value < 3) {
        cell.classList.add('bg-orange-400');
      } else if (value < 4) {
        cell.classList.add('bg-orange-500');
      } else if (value <= 5) {
        cell.classList.add('bg-orange-600');
      }
    });
  }
}
