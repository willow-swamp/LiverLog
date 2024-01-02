FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    image { "https://placehold.jp/150x150.png" }
    role { :general }
    sequence(:comment) { |n| "comment#{n}" }
    reminder { false }
    first_login { false }
    non_drinking_days { [0, 2, 4] }
  end

  trait :admin do
    role { :admin }
  end

  trait :invitee do
    role { :invitee }
  end
end
