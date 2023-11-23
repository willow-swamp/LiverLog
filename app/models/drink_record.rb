class DrinkRecord < ApplicationRecord
  belongs_to :user
  has_one :post, dependent: :destroy

  validates :user_id, presence: true, uniqueness: { scope: :start_time }
  validates :record_type, presence: true
  validates :start_time, presence: true
  validates :drink_volume, numericality: { only_integer: true, equal_to: 0 }, if: :record_type_is_no_drink?
  validates :alcohol_percentage, numericality: { equal_to: 0 }, if: :record_type_is_no_drink?
  validates :drink_volume, numericality: { greater_than_or_equal_to: 0 }, if: :record_type_is_drink?
  validates :alcohol_percentage, numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 100.0 }, if: :record_type_is_drink?
  validate :start_time_cannot_be_in_the_future

  enum record_type: { no_drink: 0, drink: 1 }

    def create_post
      @user = User.find(user_id)
      @user.groups.each do |group|
        if self.record_type == "no_drink"
          group.posts.create!(user_id: @user.id, group_id: group.id, drink_record_id: self.id, content: "#{@user.username}さんが休肝日を達成しました！！")
        else
          group.posts.create!(user_id: @user.id, group_id: group.id, drink_record_id: self.id, content: "#{@user.username}さんがお酒を嗜みました🍺（今日のアルコール摂取量：#{ApplicationController.helpers.alcohol_caluculate(self.drink_volume, self.alcohol_percentage)}g)")
        end
      end
    end

  private

  def start_time_cannot_be_in_the_future
    if start_time.present? && start_time > DateTime.current
      errors.add(:start_time, "未来の日付は使えません")
    end
  end

  def record_type_is_drink?
    record_type == "drink"
  end

  def record_type_is_no_drink?
    record_type == "no_drink"
  end
end
