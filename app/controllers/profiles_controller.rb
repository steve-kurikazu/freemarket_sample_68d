class ProfilesController < ApplicationController
  def create
    @profile = Profile.find_by(user_id: current_user.id)
    if @profile.present?
        @profile.update(profile_params)
      else
        Profile.create(profile_params)
    end
  end

  def update
    @profile = Profile.find_by(user_id: current_user.id)
    @profile.update(profile_params)
  end

  private

  def profile_params
  params.require(:profile).permit(:image ,:text).merge(user_id: current_user.id)
  end

end
