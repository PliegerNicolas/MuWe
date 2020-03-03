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

  def create_profile
    file = URI.open('https://res.cloudinary.com/dhemw39dw/image/upload/v1582053392/drum.jpg')
    profile_new = Profile.new(user_id: User.last.id)
    profile_new.profile_photo.attach(io: file, filename: 'profile.png')
    profile_new.save
    # Profile.create(user_id: User.last.id)
  end
end
