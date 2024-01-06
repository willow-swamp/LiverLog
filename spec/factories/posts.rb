FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "content#{n}" }
    association :user
    association :group
    association :drink_record
  end
end
