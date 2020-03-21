class Message < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def broadcast_message
          ActionCable.server.broadcast("event_chat_#{self.event.id}", { message_partial: ApplicationController.renderer.render(partial: "messages/message", locals: { message: self.message, user_is_message_author: false    }), current_user_id: self.user.id })
  end
end
