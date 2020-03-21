class Tchat < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
end
