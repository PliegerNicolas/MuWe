class Event < ApplicationRecord
  after_create :attach_default_event_image
  after_create :self_participate

  validates :title, :start_date, :start_time, :end_time, :max_players, presence: true
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :messages, dependent: :destroy
  belongs_to :music_style
  has_one_attached :location_photo

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :will_save_change_to_address?

  enum status: { planned: 0, ongoing: 1, finished: 2 }
  # .planned(! or ?), .active(! or ?), .finished(! or ?) to update or check the status easily

  def accepted_participants
    self.participants.where("participants.status=?", 1) # TODO: dynamically get accepted status from participants
  end

  def self_participate
    self.participants.create!(user_id: self.user_id, status: 1)
  end

  def attach_default_event_image
    image_path = '//res.cloudinary.com/dhemw39dw/image/upload/v1582662629/default_instrument_image.jpg'
    file = URI.open(image_path)
    filename = File.basename(URI.parse(image_path).path)
    self.location_photo.attach(io: file, filename: filename)
  end
end
