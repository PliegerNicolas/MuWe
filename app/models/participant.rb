class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :ratings

  enum status: { postulating: 0, accepted: 1, refused: 2 }
end
