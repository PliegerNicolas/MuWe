class CommentsController < ApplicationController
  def create
    if current_user
      @post = Post.find(params[:post_id])
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      @comment.post_id = @post.id
      authorize @comment
      if @post.participants.where(status: 'accepted', user_id: current_user).any?
        @comment.save
        respond_to do |format|
          format.html { redirect_to event_path(@event) }
          format.js
        end
      else
        respond_to do |format|
          format.html { render }
          format.js
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :message)
  end
end
