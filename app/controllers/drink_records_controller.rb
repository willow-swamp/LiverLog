class DrinkRecordsController < ApplicationController
  before_action :set_drink_record, only: %i[show edit update destroy]
  skip_before_action :require_general, only: %i[show]

  def index
    @drink_records = current_user.drink_records
  end

  def new
    @drink_record = DrinkRecord.new
  end

  def create
    @drink_record = current_user.drink_records.new(drink_record_params)
    if @drink_record.save
      @drink_record.create_post
      redirect_to drink_record_path(@drink_record), success: t('defaults.create_success')
    else
      flash.now[:error] = t 'defaults.record_error'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @drink_record_details = @drink_record.user.drink_records.where(start_time: @drink_record.start_time)
  end

  def edit; end

  def update
    @drink_record.assign_attributes(drink_record_params)
    if @drink_record.save
      redirect_to drink_record_path(@drink_record), success: t('defaults.update_success')
    else
      flash.now[:error] = t 'defaults.record_error'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @drink_record.destroy!
    redirect_to profile_path, success: t('defaults.delete_success')
  end

  private

  def drink_record_params
    record_params = params.require(:drink_record).permit(:user_id, :record_type, :start_time, :drink_type, :drink_volume,
                                                         :alcohol_percentage, :price)
    return record_params unless record_params[:record_type] == 'no_drink'

    record_params[:drink_type] = nil
    record_params[:drink_volume] = 0
    record_params[:alcohol_percentage] = 0
    record_params[:price] = 0
    record_params
  end

  def set_drink_record
    @drink_record = DrinkRecord.find(params[:id])
  end
end
