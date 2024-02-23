class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top first_login terms_of_service privacy_policy]
  skip_before_action :require_general, only: %i[top first_login terms_of_service privacy_policy]
  skip_before_action :require_first_login, only: %i[top first_login terms_of_service privacy_policy update]
  before_action :set_user, only: %i[first_login update]
  before_action :first_login?, only: %i[first_login update]

  def top; end

  def first_login; end

  def terms_of_service; end

  def privacy_policy; end

  def update
    user_params_with_days = user_params
    user_params_with_days[:non_drinking_days] = Array(user_params_with_days[:non_drinking_days]).map(&:to_i)
    if @user.update(user_params_with_days)
      redirect_to profile_path, success: 'プロフィールを登録しました'
    else
      flash.now[:error] = 'プロフィールの登録に失敗しました'
      render 'first_login', status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def first_login?
    return if @user.first_login

    redirect_to profile_path, warning: '既にプロフィールは登録済みです'
  end

  def user_params
    params.require(:user).permit(:username, :comment, :first_login, :reminder, non_drinking_days: [])
  end
end
