class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :post
end
