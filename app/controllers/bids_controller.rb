class BidsController < ApplicationController
  before_action :set_bid, only: %i[ show edit update destroy ]

  # GET /bids or /bids.json
  def index
    @bids = Bid.all
  end

  # GET /bids/1 or /bids/1.json
  def show
  end

  # GET /bids/new
  def new
    @bid = Bid.new
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids or /bids.json
      def create
      if current_user.role == 'vendor' && Bid.exists?(user_id: current_user.id, request_id: bid_params[:request_id])
        respond_to do |format|
          format.html { redirect_to bids_url, alert: "You have already submitted a bid for this request." }
          format.json { render json: { success: false, error: "You have already submitted a bid for this request." }, status: :unprocessable_entity }
        end
        return
      end
    
      @bid = Bid.new(bid_params.merge(user_id: current_user.id, status: :pending))
    
      respond_to do |format|
        if @bid.save
          format.html { redirect_to bid_url(@bid), notice: "Bid was successfully created." }
          format.json { render :show, json: { success: true, bid: @bid }, status: :created, location: @bid }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: { success: false, errors: @bid.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

    
  # PATCH/PUT /bids/1 or /bids/1.json
  def update
    respond_to do |format|
        if @bid.update(bid_params.merge(user_id: current_user.id, status: 'pending'))
        format.html { redirect_to bid_url(@bid), notice: "Bid was successfully updated." }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1 or /bids/1.json
  def destroy
    @bid.destroy

    respond_to do |format|
      format.html { redirect_to bids_url, notice: "Bid was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bid_params
      params.require(:bid).permit(:request_id, :amount)
    end
end
