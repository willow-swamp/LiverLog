class DrinkRecord < ApplicationRecord
  belongs_to :user

  validates :record_type, presence: true
  validates :start_time, presence: true
  validates :drink_volume, numericality: { greater_than_or_equal_to: 0 }
  validates :alcohol_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  enum record_type: { no_drink: 0, drink: 1 }

  def can_record_date?
    start_time <= Date.today
  end
end
