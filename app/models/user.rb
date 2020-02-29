class User < ApplicationRecord
  has_one :profile
  has_many :instrument_users
  has_many :events
  has_many :comments
  has_many :ratings
  has_many :followers
  has_many :posts
  belongs_to :participant
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
end
