class ProfilesController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def edit
  end

  def update
    user_params_with_days = user_params
    user_params_with_days[:non_drinking_days] = Array(user_params_with_days[:non_drinking_days]).map(&:to_i)
    if @user.update(user_params_with_days)
      redirect_to profile_path, success: 'プロフィールを更新しました'
    else
      flash.now[:error] = 'プロフィールの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:username, :comment, :reminder, non_drinking_days: [])
  end
end
