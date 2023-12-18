namespace :line_push do
  desc "登録した日に、LINEで休肝日を知らせる"
  task line_no_drink_day: :environment do
    require 'line/bot'

    message = {
      type: 'text',
      text: '今日は休肝日です！'
    }

    client ||= Line::Bot::Client.new { |config|
      config.channel_id = Rails.application.credentials.dig(:line_message, :channel_id)
      config.channel_secret = Rails.application.credentials.dig(:line_message, :channel_secret)
      config.channel_token = Rails.application.credentials.dig(:line_message, :channel_token)
    }

    reminder_users = User.where(reminder: true)
    reminder_users.each do |user|
      if user.non_drink_days.include?(Date.today.wday)
        client.push_message(user.authentications.first.uid, message)
      end
    end
  end
end
