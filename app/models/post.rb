class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
end
