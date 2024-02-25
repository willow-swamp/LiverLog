module DrinkRecordsHelper
  def alcohol_caluculate(volume = 0, percentage = 0)
    return 0 unless volume && percentage

    (volume.to_f * (percentage.to_f * 0.01) * 0.8).round(2)
  end

  def tweet_record(drink_record_details)
    if drink_record_details.first.record_type == 'no_drink'
      "#{drink_record_details.first.user.username}さんが休肝日を達成しました！！（#{drink_record_details.first.start_time.strftime('%m月%d日')})\n"
    else
      alert_message(drink_record_details)
    end
  end

  private

  def alert_message(drink_record_details)
    text = "#{drink_record_details.first.user.username}さんがお酒を嗜みました🍺（#{drink_record_details.first.start_time.strftime('%m月%d日')}の純アルコール量：#{drink_record_details.alcohol_caluculate}g)%0a"
    if drink_record_details.alcohol_caluculate >= 40
      text += '生活習慣病リスクが高まる可能性がある純アルコール量を超えています。明らかに飲み過ぎです😠'
      text
    elsif drink_record_details.alcohol_caluculate >= 20
      text += '生活習慣病リスクが高まる可能性がある純アルコール量を超えています。飲み過ぎには注意しましょう！'
      text
    else
      text
    end
  end
end
