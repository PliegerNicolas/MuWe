class PostsController < ApplicationController
  def create
    @profile = Profile.find(current_user.id)
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    authorize @post
    if @post.save
      respond_to do |format|
        format.html { redirect_to profile_path(@profile.id) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'profiles/profile' }
        format.js
      end
    end
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
