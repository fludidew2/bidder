import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form"]

  connect() { 
      console.log("connected dawg");
  }

  open(event) {
    event.preventDefault();
    this.modalTarget.classList.remove("hidden");
    console.log("open modal");
  }

  close(event) {
    event.preventDefault();
    this.modalTarget.classList.add("hidden");
  }

  submit(event) {
    event.preventDefault();

    // Handle form submission here
    // You might want to use fetch or axios to submit the form via AJAX
    const url = this.formTarget.action;
    const formData = new FormData(this.formTarget);

    fetch(url, {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      }
    }).then(response => {
      if (response.ok) {
        // Handle success (e.g., close the modal, show a success message)
        this.close(event);
      } else {
        // Handle errors (e.g., display error messages)
        response.text().then(html => {
          this.modalTarget.innerHTML = html;
        });
      }
    }).catch(error => {
      console.error("Form submission failed:", error);
    });
  }
}