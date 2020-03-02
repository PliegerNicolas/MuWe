class User < ApplicationRecord
  after_create :create_profile

  has_one :profile, dependent: :destroy
  has_many :instrument_users, dependent: :destroy
  has_many :events
  has_many :comments
  has_many :ratings
  has_many :followers, class_name: 'Follower', foreign_key: 'user_id'
  has_many :followeds, class_name: 'Follower', foreign_key: 'followed'
  has_many :posts
  has_many :participants, dependent: :destroy
  has_many :event_participations, through: :participants, source: :event

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def create_profile
    Profile.create(user_id: User.last.id)
  end
end
