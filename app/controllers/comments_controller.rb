class CommentsController < ApplicationController
  def create
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :event_id, :post_id, :message)
  end
end
