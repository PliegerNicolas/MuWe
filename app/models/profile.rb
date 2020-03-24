class Profile < ApplicationRecord
  after_create :attach_default_profile_image

  belongs_to :user
  has_many :instrument_users
  has_many :posts
  has_one_attached :profile_photo

  def attach_default_profile_image
    image_path = 'https://extraupdate.com/wp-content/uploads/2019/02/map_img_1138084_1501023103.jpg'
    file = URI.open(image_path)
    filename = File.basename(URI.parse(image_path).path)
    self.profile_photo.attach(io: file, filename: filename)
  end
end
