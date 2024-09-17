import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stripe"
export default class extends Controller {
  static values = { publicKey: String, clientSecret: String }
  stripe = Stripe(this.publicKeyValue)
 
  
  async connect() {
    this.checkout = await this.stripe.initEmbeddedCheckout({
      clientSecret: this.clientSecretValue,
    
    })
    this.checkout.mount(this.element)
    console.log('hello')
  }
  disconnect() {
    this.checkout.destroy()
  }
}
