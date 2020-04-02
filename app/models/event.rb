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
  scope :filter_by_duo_status, ->(status_multiple) { where(status: status_multiple) }

  def accepted_participants
    self.participants.where("participants.status=?", 1) # TODO: dynamically get accepted status from participants
  end

  def self_participate
    self.participants.create!(user_id: self.user_id, status: 1, instrument_id: Instrument.first.id)
  end

  def attach_default_event_image
    random_event_image = [
      'https://images.unsplash.com/photo-1519331379826-f10be5486c6f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
      'https://images.unsplash.com/photo-1558279209-19753befb32b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
      'https://images.unsplash.com/photo-1463839346397-8e9946845e6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1349&q=80',
      'https://images.unsplash.com/photo-1536699636578-4a910e28433a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1570375832943-a34925a7157b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1226&q=80',
      'https://images.unsplash.com/photo-1584419487266-ace409713061?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      # 'https://www.bromont.net/wp-content/uploads/2017/05/06_dijon_4_villemtl-pas-droit.png',
      # 'https://www.bromont.net/wp-content/uploads/2017/05/4649463206_c4c14d61d6_b.jpg',
      # 'https://img.fotocommunity.com/place-publique-a-guingamp-avec-fontaine-en-2010-27d34b5a-985e-4b25-96af-88d9b9a7f5f5.jpg?height=1080',
      # 'https://lh3.googleusercontent.com/proxy/mlfXCvUmwuA_94ipY8XhGmhbtL8sAXz8YkZG3Sf8UImu6LYAQI14NIsrAwtvzrEKihdrkOl-oXVIXM0w6OuWuNnTDoQGQ-d8vAXKKEPrm0dgR6VU6oHeGe7E-tijUAd54eYa0V0zurzmdbAqatza2oTGMw',
      # 'https://www.ore-peinture.fr/sites/default/files/images/_galeries/paves-granite-resine-montreuil-juigne-1_0.jpg',
      # 'https://www.leral.net/photo/art/grande/41895809-35065121.jpg?v=1579347789',
      # 'https://www.cnu.org/sites/default/files/styles/public_square_feature_image/public/washington-square-park.jpg?itok=jZoogQR3',
      # 'https://upload.wikimedia.org/wikipedia/commons/a/a4/New_Providence_NJ_public_park_with_art_and_walkways.jpg',
      # 'https://www.legalhelpline.co.uk/wp-content/uploads/2017/11/Public-Park-Accidents.jpg',
      # 'https://amp.thenational.ae/image/policy:1.834236:1584279523/na16-abudhabiparks.jpg?f=16x9&w=1200&$p$f$w=8d7cc10',
      # 'https://images.squarespace-cdn.com/content/v1/5cca36927a1fbd2fef611881/1556756465397-OFRCQV01F5B6G33EHVWT/ke17ZwdGBToddI8pDm48kDHPSfPanjkWqhH6pl6g5ph7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0mwONMR1ELp49Lyc52iWr5dNb1QJw9casjKdtTg1_-y4jz4ptJBmI9gQmbjSQnNGng/mutiny.emptybar.jpg?format=2500w',
      # 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Creston_Calif_dive_bar.jpg/1200px-Creston_Calif_dive_bar.jpg',
      # 'https://images.unsplash.com/photo-1550647382-28d025deded3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
      # 'https://www.amsterdam.info/sitemedia/photos-800/amsterdam-park-vondelpark.jpg',
      # 'https://r-cf.bstatic.com/images/hotel/max1024x768/219/219339297.jpg'
    ]

    image_path = random_event_image.sample
    file = URI.open(image_path)
    filename = File.basename(URI.parse(image_path).path)
    self.location_photo.attach(io: file, filename: filename) unless self.location_photo.attachment
  end
end
