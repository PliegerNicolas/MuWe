class PostsController < ApplicationController
  def prospect
    @posts = policy_scope(Post)
    authorize @posts
  end
end
