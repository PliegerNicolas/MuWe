class CommentsController < ApplicationController
  def create
    if current_user
      @event = Event.find(params[:event_id])
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      @comment.event_id = @event.id
      authorize @comment
      if @comment.save
        redirect_to event_path(@event)
      else
        render 'events/show'
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :event_id, :post_id, :message)
  end
end
