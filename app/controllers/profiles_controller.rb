class ProfilesController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: 'プロフィールを更新しました'
    else
      flash.now[:error] = 'プロフィールの更新に失敗しました'
      render :edit
    end
  end

  def show
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:username, :comment, :reminder)
  end
end
