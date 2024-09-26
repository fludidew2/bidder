 class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @accepted_requests_count = Request.where(status: 'accepted', winning_bid_user_id: current_user.id).count
    @completed_requests_count = Request.where(status: 'completed', winning_bid_user_id: current_user.id).count
    @live_requests_count = Request.where(status: 'live').count
    
    @requests = case params[:status]
                when 'accepted', 'completed'
                  Request.where(status: params[:status], winning_bid_user_id: current_user.id)
                         .where.not(id: DeclinedRequest.where(user_id: current_user.id).select(:request_id))
                         .order(created_at: :desc)
                else
                  Request.where(status: 'live')
                         .where.not(id: DeclinedRequest.where(user_id: current_user.id).select(:request_id))
                         .order(created_at: :desc)
                end
  
    respond_to do |format|
      format.html
      # format.turbo_stream do
      #   render turbo_stream: turbo_stream.replace(
      #     "requests", 
      #     partial: "dashboard/requests", 
      #     locals: { requests: @requests }
      #   )
      # end
    end
  end
  
 end