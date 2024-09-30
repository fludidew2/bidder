import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-hide"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    // Optional: Initialize or log connection
  }

  toggle(event) {
    event.preventDefault();
    this.menuTarget.classList.toggle("hidden");
  }

  hide(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden");
    }
  }
}