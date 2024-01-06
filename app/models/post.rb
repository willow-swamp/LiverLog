class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :drink_record
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy

  validates :id, uniqueness: { scope: :group_id }
  validates :content, length: { maximum: 256 }
end
