class Event < ApplicationRecord
  belongs_to :user
  belongs_to :city
  belongs_to :music_style
end
