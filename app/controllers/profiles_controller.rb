class ProfilesController < ApplicationController
  def profile
    @profile = User.find(params[:id]).profile
    authorize @profile
  end

  def edit
    find_profile
  end

  def update
    find_profile
    @profile.update(profile_params)
    @profile.user.update(user_params)
    redirect_to edit_profile_path, notice: "Profile updated"
  end

  private

  def profile_params
    params.require(:profile).permit(:city, :last_name, :birth_date, :bio, :profile_photo)
  end

  def user_params
    profile_require = params.require(:profile)
    profile_require.require(:user).permit(:email, :first_name)
  end

  def find_profile
    @profile = current_user.profile
    authorize @profile
  end
end
