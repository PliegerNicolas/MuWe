class Event < ApplicationRecord
  # validates :title, :start_date, :start_time, :end_time, :address, :max_players, presence: true
  validates :title, :start_date, :start_time, :end_time, :max_players, presence: true
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :comments
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
end
