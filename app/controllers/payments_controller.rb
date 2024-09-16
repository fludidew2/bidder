class PaymentsController < ApplicationController
  def generate
    request = Request.find(params[:request_id])
    bid = request.bids.find(params[:bid_id])
    user = request.user

    # Generate invoice using Stripe
    invoice = Stripe::Invoice.create({
      customer: user.stripe_customer_id,
      auto_advance: true, # Auto-finalize this draft after ~1 hour
      collection_method: 'send_invoice',
      days_until_due: 30,
      description: "Invoice for bid ##{bid.id}",
      metadata: {
        request_id: request.id,
        bid_id: bid.id
      }
    })

    # Send invoice to the requester's email
    Stripe::Invoice.send_invoice(invoice.id)

    redirect_to request_path(request), notice: 'Invoice generated and sent to the requester.'
  rescue Stripe::StripeError => e
    redirect_to request_path(request), alert: "Error generating invoice: #{e.message}"
  end
end