class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups

  validates :name, presence: true
  validates :group_admin_id, presence: true

  def save_group_member(user)
    self.users << user
  end

  def group_admin
    User.find(self.group_admin_id)
  end
end
