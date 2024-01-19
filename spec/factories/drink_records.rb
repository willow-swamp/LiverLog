FactoryBot.define do
  factory :drink_record do
    record_type { 1 }
    start_time { '2021-01-01 00:00:00' }
    drink_type { 'ビール' }
    drink_volume { 350 }
    alcohol_percentage { 5.0 }
    price { 300 }
    association :user

    trait :no_drink do
      record_type { 0 }
      drink_volume { 0 }
      alcohol_percentage { 0.0 }
      price { 0 }
    end
  end
end
