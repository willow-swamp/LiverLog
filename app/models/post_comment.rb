class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :message, presence: true, length: { maximum: 1000 }
end
