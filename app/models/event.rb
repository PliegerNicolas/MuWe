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

  scope :filter_by_periode_uniq, ->(periode) { where(start_date: periode) }
  scope :filter_by_periode_multiple, ->(periodes) { where('start_date BETWEEN ? AND ?', periodes[0], periodes[1]) }
  scope :filter_by_time, ->(time) { where('start_time >= ? AND end_time <= ?', time[0], time[1]) }
  scope :filter_by_max_players, ->(max_players) { where(max_players: max_players) }
  scope :filter_by_status, ->(status) { where(status: status) }

  def accepted_participants
    self.participants.where("participants.status=?", 1) # TODO: dynamically get accepted status from participants
  end

  def self_participate
    self.participants.create!(user_id: self.user_id, status: 1)
  end

  def attach_default_event_image
    image_path = 'https://images.unsplash.com/photo-1415201364774-f6f0bb35f28f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'
    file = URI.open(image_path)
    filename = File.basename(URI.parse(image_path).path)
    self.location_photo.attach(io: file, filename: filename)
  end
end
