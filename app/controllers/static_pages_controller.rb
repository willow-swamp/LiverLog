class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:top]
  before_action :set_user, only: [:first_login, :update]
  before_action :first_login?, only: [:first_login, :update]

  def top
  end

  def first_login
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: 'プロフィールを登録しました'
    else
      flash.now[:error] = 'プロフィールの登録に失敗しました'
      render 'first_login'
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def first_login?
    if !@user.first_login
      redirect_to profile_path, warning: '既にプロフィールは登録済みです'
    end
  end

  def user_params
    params.require(:user).permit(:username, :comment, :first_login)
  end
end
