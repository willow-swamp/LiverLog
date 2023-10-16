module DrinkRecordsHelper
  def alcohol_caluculate(volume = 0, percentage = 0)
    return 0 unless volume && percentage
    volume.to_f * (percentage.to_f * 0.01) * 0.8
  end
end
