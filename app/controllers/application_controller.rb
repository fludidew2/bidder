class ApplicationController < ActionController::Base

  def check_stripe_setup
    if current_user.artist? && !current_user.stripe_account_setup?
      @show_stripe_alert = true
    else
      @show_stripe_alert = false
    end
  end

protected

  def after_sign_in_path_for(resource)
    dashboard_path # This will redirect users to the Albums index
  end


end
