# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[edit update]
  layout 'dashboard'

  def edit
    @profile = current_user.profile
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = 'Profile was successfully updated.'
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:business_name, :about, :street_address, :city, :state, :zip_code, :phone, :email_address, :first_name, :last_name)
  end
end