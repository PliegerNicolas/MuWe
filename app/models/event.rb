class Event < ApplicationRecord
  belongs_to :user
  belongs_to :city
  belongs_to :music_style
  has_many :participants
  has_many :comments
end
