 class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.buyer?
      @requests = current_user.requests.order(created_at: :desc)
    else
    @requests = Request.all
    end
  end


 end