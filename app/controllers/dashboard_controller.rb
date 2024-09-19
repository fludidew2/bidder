 class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
   
    @requests = if current_user.buyer?
                  current_user.requests.order(created_at: :desc)
                else
                   status = params[:status] || 'live'
                  Request.where(status: status).order(created_at: :desc)
                end

    respond_to do |format|
      format.html
      # format.turbo_stream { render turbo_stream: turbo_stream.replace("requests", partial: "requests", locals: { requests: @requests }) }
    end
  end

 end