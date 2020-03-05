class Profile < ApplicationRecord
  belongs_to :user
  has_many :instrument_users
  has_one_attached :profile_photo
end
