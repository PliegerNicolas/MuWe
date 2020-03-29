class UserlocationController < ApplicationController
  def save_location
    init_user_pos = params[:init_user_pos]

    @profile = Profile.find(current_user.profile.id) if current_user

    if @profile.latitude.blank? && @profile.longitude.blank?
      @profile.latitude = init_user_pos[0]
      @profile.longitude = init_user_pos[1]
    elsif @profile && @profile.distance_from(init_user_pos) >= 10
      @profile.latitude = init_user_pos[0]
      @profile.longitude = init_user_pos[1]
    end
  end
end
