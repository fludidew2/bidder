import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    this.element.addEventListener("turbo:submit-end", this.clearForm.bind(this));
  }

  clearForm(event) {
    if (event.detail.success) {
      this.element.reset();
    }
  }
}