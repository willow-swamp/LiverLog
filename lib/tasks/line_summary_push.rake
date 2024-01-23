namespace :line_summary_push do
  desc '一週間の記録をまとめてLINEで通知する'
  task line_summary_push: :environment do
    require 'line/bot'

    message = {
      type: 'text',
      text: ''
    }

    client ||= Line::Bot::Client.new do |config|
      config.channel_id = Rails.application.credentials.dig(:line_message, :channel_id)
      config.channel_secret = Rails.application.credentials.dig(:line_message, :channel_secret)
      config.channel_token = Rails.application.credentials.dig(:line_message, :channel_token)
    end

    def week_summary(user)
      user.drink_records.where(start_time: Date.today.prev_week.beginning_of_week..Date.today.prev_week.end_of_week)
    end

    def week_total_amount_alcohol(user)
      total_amount_alcohol = 0
      week_summary(user).drink.each do |drink_record|
        amount_alcohol = drink_record.drink_volume.to_f * (drink_record.alcohol_percentage.to_f * 0.01) * 0.8
        total_amount_alcohol += amount_alcohol
      end
      total_amount_alcohol.round(1)
    end

    reminder_users = User.where(reminder: true)
    if Date.today.monday?
      reminder_users.each do |user|
        message[:text] =
          "先週（月〜日）の記録です！\n休肝日：#{week_summary(user).no_drink.count}日\nお酒を飲んだ日：#{week_summary(user).drink.count}日\nお酒を飲んだ日の合計量：#{week_total_amount_alcohol(user)}g\nお酒を飲んだ日の合計金額：#{week_summary(user).drink.sum(:price)}円\n\n今週も頑張りましょう！"
        client.push_message(user.authentications.first.uid, message)
      end
    end
  end
end
