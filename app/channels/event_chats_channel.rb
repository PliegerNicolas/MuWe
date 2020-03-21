class EventChatsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "event_chat_#{params[:event_chat_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
