class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  has_many :drink_records, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :username, presence: true
  validates :comment, length: { maximum: 256 }
  validates :non_drinking_days, presence: true

  def monthly_no_drink_day_records
    self.drink_records.no_drink.where(start_time: Date.today.all_month).count
  end

  def monthly_non_drinking_days
    # 当月の初日から当日までの日付を取得
    days = Date.today.beginning_of_month..Date.today
    # non_drinking_daysの配列に当月の日付が含まれているかどうかを判定
    days.select { |day| self.non_drinking_days.include?(day.wday) }.count
  end

  def monthly_no_drink_achievement
    return 0 if self.monthly_non_drinking_days == 0
    (self.monthly_no_drink_day_records.to_f / self.monthly_non_drinking_days.to_f * 100).round(1)
  end

  def monthly_total_amount_alcohol
    total_amount_alcohol = 0
    self.drink_records.drink.where(start_time: Date.today.all_month).each do |drink_record|
      amount_alcohol = drink_record.drink_volume.to_f * (drink_record.alcohol_percentage.to_f * 0.01) * 0.8
      total_amount_alcohol += amount_alcohol
    end
    return total_amount_alcohol.round(1)
  end

  def last_manth_total_amount_alcohol
    total_amount_alcohol = 0
    self.drink_records.drink.where(start_time: Date.today.last_month.all_month).each do |drink_record|
      amount_alcohol = drink_record.drink_volume.to_f * (drink_record.alcohol_percentage.to_f * 0.01) * 0.8
      total_amount_alcohol += amount_alcohol
    end
    return total_amount_alcohol.round(1)
  end

  def compare_rate_last_manth_total_amount_alcohol
    return 0 if self.last_manth_total_amount_alcohol == 0
    (self.monthly_total_amount_alcohol.to_f / self.last_manth_total_amount_alcohol.to_f * 100).round(1)
  end

  def compare_amount_last_manth_total_amount_alcohol
    (self.monthly_total_amount_alcohol.to_f - self.last_manth_total_amount_alcohol.to_f).round(1)
  end
end
