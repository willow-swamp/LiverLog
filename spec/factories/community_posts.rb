FactoryBot.define do
  factory :community_post do
    sequence(:content) { |n| "コミュニティポスト#{n}" }
    image { 'https://placehold.jp/150x150.png' }
    association :user
  end
end
