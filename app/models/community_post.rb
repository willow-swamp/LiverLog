class CommunityPost < ApplicationRecord
  belongs_to :user
  has_many :community_post_likes, dependent: :destroy
  has_many :community_post_comments, dependent: :destroy

  validates :content, presence: true, length: { maximum: 256 }
  validates :user_id, presence: true
end
