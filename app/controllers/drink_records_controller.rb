class DrinkRecordsController < ApplicationController
  def new
    @drink_record = DrinkRecord.new
  end

  def create
    @drink_record = current_user.drink_records.new(drink_record_params)
    if @drink_record.can_record_date?
      if @drink_record.save
        redirect_to profile_path
      else
        render :new
      end
    else
      flash.now[:error] = "You can't record date in the future."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def drink_record_params
    params.require(:drink_record).permit(:user_id, :record_type, :start_time, :drink_type, :drink_volume, :alcohol_percentage)
  end
end
