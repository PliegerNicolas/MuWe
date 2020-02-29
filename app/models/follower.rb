class Follower < ApplicationRecord
  belongs_to :user
  belongs_to :followed, class_name: 'User', foreign_key: 'user_id'
end
