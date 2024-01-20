FactoryBot.define do
  factory :post do
    content { "#{user.username}さんが休肝日を達成しました！！" }
    association :user
    association :group
    association :drink_record
  end

  trait :drink do
    content { "#{user.username}さんがお酒を嗜みました🍺（今日のアルコール摂取量：#{ApplicationController.helpers.alcohol_caluculate(drink_record.drink_volume, drink_record.alcohol_percentage)}g）" }
  end
end