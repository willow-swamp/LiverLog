class Invitees::InvitationController < ApplicationController
  skip_before_action :require_login, only: %i[new first_login]
  skip_before_action :require_general, only: %i[new first_login update]
  skip_before_action :require_first_login, only: %i[new first_login update]
  before_action :group_invite_token, only: %i[new]
  before_action :set_user, only: %i[first_login update]

  def new; end

  def first_login; end

  def update
    if @user.update(user_params)
      redirect_to group_path(@user.groups.first), success: 'プロフィールを登録しました'
    else
      flash.now[:error] = 'プロフィールの登録に失敗しました'
      render 'first_login'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :first_login)
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def first_login?
    return if @user.first_login

    redirect_to group_path(@user.group.first), warning: '既にプロフィールは登録済みです'
  end

  def group_invite_token
    @group = Group.find_by(invite_token: params[:invite_token])
  end
end
