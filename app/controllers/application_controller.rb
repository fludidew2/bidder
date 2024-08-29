class ApplicationController < ActionController::Base

protected

  def after_sign_in_path_for(resource)
    dashboard_path # This will redirect users to the Albums index
  end


end
