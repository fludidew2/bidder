class CheckoutController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])

    # Calculate the amount and ensure it's at least $0.50 USD
    amount = (@invoice.amount * 100).to_i
  

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: 'Invoice Payment',
          },
          unit_amount: amount, # Ensure amount is at least $0.50 USD
        },
        quantity: 1,
      }],
      mode: 'payment',
      automatic_tax: {enabled: true},
      ui_mode: 'embedded', # Optional: Adjust as needed
      return_url: invoice_url(@invoice), # Specify return_url
      # redirect_on_completion: 'never', # Alternatively, disable redirects
    )


  end
end