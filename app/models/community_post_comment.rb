class CommunityPostComment < ApplicationRecord
  belongs_to :user
  belongs_to :community_post

  validates :message, presence: true, length: { maximum: 256 }
end
