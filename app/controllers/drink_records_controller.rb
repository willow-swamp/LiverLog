class DrinkRecordsController < ApplicationController
  before_action :set_drink_record, only: [:show, :edit, :update, :destroy]

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
  end

  def edit
  end

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
    params.require(:drink_record).permit(:user_id, :record_type, :start_time, :drink_type, :drink_volume, :alcohol_percentage)
  end

  def set_drink_record
    @drink_record = current_user.drink_records.find(params[:id])
  end
end
