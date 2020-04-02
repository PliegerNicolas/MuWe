class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :instrument

  has_many :ratings

  enum status: { postulating: 0, accepted: 1, declined: 2 }
end
