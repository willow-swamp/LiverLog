FactoryBot.define do
  factory :post_comment do
    sequence(:message) { |n| "コメント#{n}" }
    association :user
    association :post
  end
end
