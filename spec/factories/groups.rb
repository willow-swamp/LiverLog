FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "group#{n}" }
    invite_token { SecureRandom.hex(16) }
    association :group_admin, factory: :user
  end
end
