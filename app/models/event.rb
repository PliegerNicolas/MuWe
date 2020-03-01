class Event < ApplicationRecord
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :comments
  has_many :cities
  has_many :music_styles

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
