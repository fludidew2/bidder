class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy ]
  layout 'dashboard'


  def index
    @requests = Request.where(status: params[:status])

    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.replace("requests", partial: "requests", locals: { requests: @requests }) }
    end
  end

  

  # GET /requests/1 or /requests/1.json
  def show
    console
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests or /requests.json
  def create
    @request = Request.new(request_params)
    @request.user = current_user # Assuming a request belongs to a user
    @request.status = :live# Assuming a request starts as open


    respond_to do |format|
      if @request.save
        flash[:notice] = "Request was successfully created."
        format.html { redirect_to dashboard_path }
        format.json { render :show, status: :created, location: @request }
      else
        flash[:alert] = "There was an error creating the request."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to request_url(@request), notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end



  def accept_bid
    @request = Request.find(params[:id])
    @bid = @request.bids.find(params[:bid_id])

    ActiveRecord::Base.transaction do
      @request.update!(accepted: true, bidding_closed: true, status: :accepted)
      @bid.update!(status: :winning)
    end

    flash[:notice] = 'Bid was successfully accepted. Further bidding is now closed.'
    redirect_to @request
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = "There was an error accepting the bid: #{e.message}"
    redirect_to @request
  end

    def destroy
    if current_user.role == 'vendor'
      DeclinedRequest.create(user: current_user, request: @request)
      flash[:notice] = "Request was successfully declined."
    else
      @request.destroy
      flash[:notice] = "Request was successfully destroyed."
    end
  
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:description)
    end
end
