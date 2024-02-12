FactoryBot.define do
  factory :post do
    content { "#{user.username}さんが休肝日を達成しました！！" }
    association :user
    association :group
    association :drink_record
  end

  trait :drink do
    content do
      "#{user.username}さんがお酒を嗜みました🍺（#{drink_record.start_time.strftime('%m月%d日')}のアルコール摂取量：#{ApplicationController.helpers.alcohol_caluculate(
        drink_record.drink_volume, drink_record.alcohol_percentage
      )}g）"
    end
  end
end
