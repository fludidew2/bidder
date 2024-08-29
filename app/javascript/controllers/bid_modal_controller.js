// app/javascript/controllers/bid_modal_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form"]

  connect() {
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    console.log("connected")
  }

  open(event) {
    const index = event.target.getAttribute('data-bid-modal-index')
    const modal = this.modalTargets.find(modal => modal.getAttribute('data-bid-modal-index') === index)
    modal.classList.remove('hidden')
  }

  close(event) {
    const index = event.target.closest('[data-bid-modal-index]').getAttribute('data-bid-modal-index')
    const modal = this.modalTargets.find(modal => modal.getAttribute('data-bid-modal-index') === index)
    modal.classList.add('hidden')
  }

  submitForm(event) {
    event.preventDefault()
    const form = event.target
    const index = form.closest('[data-bid-modal-index]').getAttribute('data-bid-modal-index')
    const modal = this.modalTargets.find(modal => modal.getAttribute('data-bid-modal-index') === index)
    const formData = new FormData(form)

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
        modal.classList.add('hidden')
        alert('Bid submitted successfully!')
      } else {
        alert('Error submitting bid.')
      }
    })
    .catch(error => {
      console.error('Error:', error)
      alert('Error submitting bid.')
    })
  }
}