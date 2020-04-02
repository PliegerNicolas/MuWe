class Instrument < ApplicationRecord
  has_many :instrument_users

  scope :order_by_name, -> { order(name: :asc) }
end
