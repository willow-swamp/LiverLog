class DrinkRecord < ApplicationRecord
  belongs_to :user

  validates :record_type, presence: true
  validates :start_time, presence: true

  enum record_type: { no_drink: 0, drink: 1 }

  def can_record_date?
    start_time <= Date.today
  end
end
