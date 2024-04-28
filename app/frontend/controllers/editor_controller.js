import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['marketSegmentContainer', 'paymentMethodTemplate'];

  initialize() {
    this.marketSegmentIndex = 0;

    if (this.marketSegmentContainerTarget.lastElementChild.dataset.index) {
      this.marketSegmentIndex = parseInt(
        this.marketSegmentContainerTarget.lastElementChild.dataset.index, 10,
      ) + 1;
    }
  }

  addSegment() {
    const marketSegmentInputElement = this.getSegmentInput();

    this.marketSegmentContainerTarget.insertAdjacentHTML(
      'beforeend',
      marketSegmentInputElement,
    );
    this.marketSegmentIndex += 1;
  }

  getSegmentInput() {
    return this.paymentMethodTemplateTarget.innerHTML
      .replace(/{INDEX}/g, this.marketSegmentIndex)
      .replace(/{INDEX_NUMBER}/g, this.marketSegmentIndex + 1);
  }
}
