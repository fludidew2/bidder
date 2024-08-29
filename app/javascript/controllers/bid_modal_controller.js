import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form"]

  connect() {
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    console.log('CSRF Token:', this.csrfToken); // Debugging statement
  }

  open(event) {
    const index = event.target.getAttribute('data-bid-modal-index');
    const modal = this.modalTargets.find(modal => modal.getAttribute('data-bid-modal-index') === index);
    modal.classList.remove('hidden');
  }

  close(event) {
    const index = event.target.closest('[data-bid-modal-index]').getAttribute('data-bid-modal-index');
    const modal = this.modalTargets.find(modal => modal.getAttribute('data-bid-modal-index') === index);
    modal.classList.add('hidden');
  }

  submitForm(event) {
    event.preventDefault();
    const form = event.target;
    const formData = new FormData(form);
  
    // Debugging statement
    for (let [key, value] of formData.entries()) {
      console.log(`${key}: ${value}`);
    }
  
    fetch('/bids', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': this.csrfToken,
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(Object.fromEntries(formData))
    })
    .then(response => response.json())
    .then(data => {
      console.log('Response data:', data); 
      if (data.success) {
        alert('Bid submitted successfully!');
        // Close the modal
        const index = form.closest('[data-bid-modal-index]').getAttribute('data-bid-modal-index');
        const modal = this.modalTargets.find(modal => modal.getAttribute('data-bid-modal-index') === index);
        modal.classList.add('hidden');
      } else {
        alert(data.error);
        const index = form.closest('[data-bid-modal-index]').getAttribute('data-bid-modal-index');
        const modal = this.modalTargets.find(modal => modal.getAttribute('data-bid-modal-index') === index);
        modal.classList.add('hidden');
      }
    })
    .catch(error => {
      console.error('Error:', error);
      alert('Error submitting bid.');
    });
  }
}