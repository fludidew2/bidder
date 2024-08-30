# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[edit update]
  layout 'dashboard'

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to dashboard_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:business_name, :address)
  end
end