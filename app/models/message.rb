class Message < ApplicationRecord
  after_create :broadcast_message

  belongs_to :user
  belongs_to :event

  validates :message, presence: true

  def broadcast_message
    ActionCable.server.broadcast("event_chat_#{event.id}", { message_partial: ApplicationController.renderer.render(partial: "messages/message", locals: { message: self, user_is_message_author: false }), current_user_id: user.id })
  end
end
