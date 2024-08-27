 class DashboardController < ApplicationController

  def index
    @requests = Request.all
  end


 end