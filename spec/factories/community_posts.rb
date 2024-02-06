FactoryBot.define do
  factory :community_post do
    content { "MyText" }
    image { "MyString" }
    user { nil }
  end
end
