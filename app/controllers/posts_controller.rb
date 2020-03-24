class PostsController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
      raise
  end

  def edit

  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:user_id, :description, :reference)
  end
end
