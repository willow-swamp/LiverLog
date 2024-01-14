FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "group#{n}" }
    invite_token { SecureRandom.hex(16) }
    group_admin_id { 1 }

    after(:create) do |group|
      create(:user_group, group: group, user: create(:user, :invitee))
    end
  end
end
