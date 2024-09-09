class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]
  layout 'dashboard'
  # GET /invoices or /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1 or /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  def generate
    request = Request.find(params[:request_id])
    bid = Bid.find(params[:bid_id])
    
    # Logic to generate the invoice
    invoice = Invoice.new(
      request: request,
      bid: bid,
      request_description: request.description,
      amount: bid.amount
    )

    if invoice.save
      # Handle successful invoice generation
      redirect_to invoice_path(invoice), notice: 'Invoice generated successfully.'
    else
      # Handle errors
      redirect_back fallback_location: root_path, alert: 'Failed to generate invoice.'
    end
  end

  # POST /invoices or /invoices.json
  # def create
  #   @invoice = Invoice.new(invoice_params)

  #   respond_to do |format|
  #     if @invoice.save
  #       format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully created." }
  #       format.json { render :show, status: :created, location: @invoice }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @invoice.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.require(:invoice).permit(:request_id, :bid_id, :request_description, :amount)

    end
end
