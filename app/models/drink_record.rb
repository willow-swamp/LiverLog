class DrinkRecord < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :start_time }
  validates :record_type, presence: true
  validates :start_time, presence: true
  validates :drink_volume, absence: true, if: :record_type_is_no_drink?
  validates :alcohol_percentage, absence: true, if: :record_type_is_no_drink?
  validates :drink_volume, numericality: { greater_than_or_equal_to: 0 }, if: :record_type_is_drink?
  validates :alcohol_percentage, numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 100.0 }, if: :record_type_is_drink?
  validate :start_time_cannot_be_in_the_future

  enum record_type: { no_drink: 0, drink: 1 }

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