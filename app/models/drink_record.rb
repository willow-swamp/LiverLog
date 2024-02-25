class DrinkRecord < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :start_time, presence: true, uniqueness: { scope: :user_id, message: '：同じ日に休肝日を複数記録することはできません' },
                         if: :record_type_is_no_drink?
  validate :no_drink_and_drink_cannot_be_same_day, if: :record_type_is_drink?, unless: lambda {
                                                                                         validation_context == :update
                                                                                       }
  validates :record_type, presence: true
  validates :user_id, presence: true
  validates :drink_volume, numericality: { only_integer: true, equal_to: 0 }, if: :record_type_is_no_drink?
  validates :alcohol_percentage, numericality: { equal_to: 0 }, if: :record_type_is_no_drink?
  validates :drink_volume, numericality: { greater_than_or_equal_to: 0 }, if: :record_type_is_drink?
  validates :alcohol_percentage, numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 100.0 },
                                 if: :record_type_is_drink?
  validate :start_time_cannot_be_in_the_future
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :record_type_is_drink?
  validates :price, numericality: { only_integer: true, equal_to: 0 }, if: :record_type_is_no_drink?

  enum record_type: { no_drink: 0, drink: 1 }

  scope :record_today, -> { where(start_time: Time.zone.now.all_day) }
  scope :record_yesterday, -> { where(start_time: 1.day.ago.all_day) }
  scope :record_2days_ago, -> { where(start_time: 2.days.ago.all_day) }
  scope :record_3days_ago, -> { where(start_time: 3.days.ago.all_day) }
  scope :record_4days_ago, -> { where(start_time: 4.days.ago.all_day) }
  scope :record_5days_ago, -> { where(start_time: 5.days.ago.all_day) }
  scope :record_6days_ago, -> { where(start_time: 6.days.ago.all_day) }

  scope :alcohol_caluculate, -> { sum('drink_volume * alcohol_percentage * 0.01 * 0.8').round(2) }

  DRINK_TYPES = { beer: 'ビール', wine: 'ワイン', sake: '日本酒', shochu: '焼酎', whiskey: 'ウイスキー', highball: 'ハイボール' }.freeze
  DRINK_VOLUME = %w[60 180 350 500 720 1000].freeze
  ALCOHOL_PERCENTAGE = %w[3.0 5.0 7.0 9.0 12.0 15.0 18.0 20.0 25.0 30.0 35.0 37.0 40.0 45.0 50.0].freeze

  def create_post
    @user = User.find(user_id)
    @user.groups.each do |group|
      if record_type == 'no_drink'
        group.posts.create!(user_id: @user.id, group_id: group.id, drink_record_id: id,
                            content: "#{@user.username}さんが休肝日を達成しました！！（#{start_time.strftime('%m月%d日')}）")
      else
        group.posts.create!(user_id: @user.id, group_id: group.id, drink_record_id: id,
                            content: "#{@user.username}さんがお酒を嗜みました🍺（#{start_time.strftime('%m月%d日')}のアルコール摂取量：#{ApplicationController.helpers.alcohol_caluculate(drink_volume, alcohol_percentage)}g）")
      end
    end
  end

  private

  def start_time_cannot_be_in_the_future
    return unless start_time.present? && start_time > DateTime.current

    errors.add(:start_time, 'は未来の日付で登録できません')
  end

  def record_type_is_drink?
    record_type == 'drink'
  end

  def record_type_is_no_drink?
    record_type == 'no_drink'
  end

  def no_drink_and_drink_cannot_be_same_day
    return unless DrinkRecord.where(user_id:, start_time:, record_type: 'no_drink').exists?

    errors.add(:start_time, '：同じ日に休肝日と飲酒日を記録することはできません')
  end
end
