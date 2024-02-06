class CommunityPost < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 256 }
  validates :user_id, presence: true
end
