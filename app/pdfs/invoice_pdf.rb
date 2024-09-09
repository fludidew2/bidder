# app/pdfs/invoice_pdf.rb
class InvoicePdf < Prawn::Document
  def initialize(invoice)
    super()
    @invoice = invoice
    font "Helvetica"
    header
    company_info
    company_to
    remit_to
    text_content
  end

   def header
    text "Invoice ##{@invoice.id}", size: 5, style: :bold, align: :left
    stroke_horizontal_rule
    move_down 20
   end

  def company_info
    text "From:", size: 5, style: :bold
    move_down 2
    text "#{@invoice.bid.user.profile.business_name}", size: 5
    text "#{@invoice.bid.user.profile.street_address}", size: 5
    text "#{@invoice.bid.user.profile.city}, #{@invoice.bid.user.profile.state} #{@invoice.bid.user.profile.zip_code}", size: 5
    move_down 20
  end

  def company_to
    text "To:", size: 5, style: :bold
    move_down 2
    text "#{@invoice.request.user.profile.business_name}", size: 5
    text "#{@invoice.request.user.profile.street_address}", size: 5
    text "#{@invoice.request.user.profile.city}, #{@invoice.request.user.profile.state} #{@invoice.request.user.profile.zip_code}", size: 5
    move_down 20
  end

  def remit_to
    text "Issued On: #{@invoice.created_at.strftime("%B %d, %Y")}", size: 5
    due_date = @invoice.created_at + 30.days
    text "Due On: #{due_date.strftime("%B %d, %Y")}", size: 5
    move_down 20
   
  end

  def text_content
    text "Request Description:", size: 5, style: :bold
    text "#{@invoice.request_description}", size: 5
    move_down 5
    text "Amount: #{ActionController::Base.helpers.number_to_currency(@invoice.amount)}", size: 5, style: :bold
    move_down 20
    text "Thank you for your business!", size: 8, align: :center
  end
end