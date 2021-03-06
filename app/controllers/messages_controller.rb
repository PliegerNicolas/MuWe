class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @event = Event.find(params[:event_id])
    @message.event = @event
    @message.user = current_user if current_user
    authorize @message
    if @message.save
      respond_to do |format|
        format.html { redirect_to event_path(@event.id) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "event/show" }
        format.js
      end
    end
  end

  def destroy
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end
end
