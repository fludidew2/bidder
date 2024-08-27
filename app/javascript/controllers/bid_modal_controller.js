// app/javascript/controllers/bid_modal_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form"];

  connect() {
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }

  openModal() {
    this.modalTarget.classList.remove('hidden');
  }

  closeModal() {
    this.modalTarget.classList.add('hidden');
  }

  submitForm(event) {
    event.preventDefault();
    const formData = new FormData(this.formTarget);

    fetch('/bids', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': this.csrfToken
      },
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        this.closeModal();
        alert('Bid submitted successfully!');
      } else {
        alert('Error submitting bid.');
      }
    })
    .catch(error => {
      console.error('Error:', error);
      alert('Error submitting bid.');
    });
  }
}