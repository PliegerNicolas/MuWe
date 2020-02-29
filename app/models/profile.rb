class Profile < ApplicationRecord
  belongs_to :user
  has_many :cities
end
