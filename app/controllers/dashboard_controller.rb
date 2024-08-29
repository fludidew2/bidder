 class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = Request.all
  end


 end