class Invitees::InvitationController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :require_general, only: %i[new first_login update]
  before_action :group_invite_token, only: %i[new]

  def new; end

  def first_login; end

  def update
    if @user.update(user_params_with_days)
      redirect_to group_path(@user.groups.first), success: 'プロフィールを登録しました'
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
      redirect_to group_path(@user.group.first), warning: '既にプロフィールは登録済みです'
    end
  end

  def group_invite_token
    @group = Group.find_by(invite_token: params[:invite_token])
  end
end
