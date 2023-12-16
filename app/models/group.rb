class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :group_admin_id, presence: true
  validates :invite_token, presence: true, uniqueness: true

  def save_group_member(user)
    self.users << user
  end

  def group_admin
    User.find(self.group_admin_id)
  end

  def group_admin?(user)
    user == self.group_admin
  end

  def set_invite_token
    self.invite_token = SecureRandom.hex(16)
  end
end
