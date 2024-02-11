FactoryBot.define do
  factory :community_post_comment do
    message { "MyText" }
    user { nil }
    post { nil }
  end
end
