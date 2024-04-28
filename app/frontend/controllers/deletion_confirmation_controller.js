import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['button', 'confirmationField'];

  validateConfirmationInput() {
    if (this.confirmationFieldTarget.value === this.data.get('project-name')) {
      this.buttonTarget.disabled = false;
      this.buttonTarget.classList.remove('opacity-50');
    } else {
      this.buttonTarget.disabled = true;
      this.buttonTarget.classList.add('opacity-50');
    }
  }
}
