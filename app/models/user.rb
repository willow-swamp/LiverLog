class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  has_many :drink_records, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :username, presence: true
  validates :comment, length: { maximum: 256 }
end
