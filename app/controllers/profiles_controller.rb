class ProfilesController < ApplicationController
  def profile
    @profile = User.find(params[:id]).profile
    authorize @profile
  end
end
