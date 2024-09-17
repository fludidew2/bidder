class PaymentsController < ApplicationController
  def show
    @invoice = Invoice.find(params[:invoice_id]) # Adjust as needed

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: 'Invoice Payment',
        amount: (@invoice.amount * 1.10).to_i, # Adjust amount as needed
        currency: 'usd',
        quantity: 1,
      }],
      mode: 'payment',
      success_url: root_url, # Adjust as needed
      cancel_url: root_url,  # Adjust as needed
    )

    render json: { id: session.id }
  end
end