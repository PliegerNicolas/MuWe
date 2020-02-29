class Event < ApplicationRecord
  belongs_to :user
  has_many :participants
  has_many :comments
  has_many :cities
  has_many :music_styles
  # belongs_to :city
  # belongs_to :music_style
end
