class CheckoutController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])

    # Calculate the amount and ensure it's at least $0.50 USD
    amount = (@invoice.amount * 1.10).to_i
    amount = [amount, 50].max

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
      success_url: root_url, # Adjust as needed
      cancel_url: root_url,  # Adjust as needed
    )

    render json: { id: @session.id }
  end
end