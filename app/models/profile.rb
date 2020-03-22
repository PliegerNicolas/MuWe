class Profile < ApplicationRecord
  after_create :attach_default_profile_image

  belongs_to :user
  has_many :instrument_users
  has_one_attached :profile_photo

  def attach_default_profile_image
    image_path = 'https://res.cloudinary.com/dhemw39dw/image/upload/v1582662629/default_instrument_image.jpg'
    file = URI.open(image_path)
    filename = File.basename(URI.parse(image_path).path)
    self.profile_photo.attach(io: file, filename: filename)
  end
end
