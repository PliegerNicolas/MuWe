class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :ratings
end
