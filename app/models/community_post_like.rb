class CommunityPostLike < ApplicationRecord
  belongs_to :user
  belongs_to :community_post

  validates :user_id, uniqueness: { scope: :community_post_id }
end
