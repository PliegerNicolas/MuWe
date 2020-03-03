class MusicStyle < ApplicationRecord
  has_many :events

  def to_label
    style
  end
end
