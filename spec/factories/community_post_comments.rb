FactoryBot.define do
  factory :community_post_comment do
    sequence(:message) { |n| "コミュニティコメントのコメント#{n}" }
    association :user
    association :community_post
  end
end
