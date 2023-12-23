class OauthsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_general
  before_action :already_logged_in, only: [:oauth, :callback]

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      if @user.general? || @user.admin?
        redirect_to profile_path, success: t('defaults.login_success')
      elsif @user.invitee?
        redirect_to group_path(@user.groups.first), success: t('defaults.login_success')
      end
    else
      begin
        if session[:invite_token].present?
          @user = create_from(provider)
          @user.role = :invitee
          group = Group.find_by(invite_token: session[:invite_token])
          binding.pry
          group.save_group_member(@user)
          reset_session
          auto_login(@user)
          redirect_to invitees_invitation_first_login_path, success: t('defaults.login_success')
        else
          @user = create_from(provider)
          reset_session
          auto_login(@user)
          redirect_to first_login_path, success: t('defaults.login_success')
        end
      rescue
        redirect_to root_path, error: t('defaults.login_failed')
      end
    end
  end

  private

  def already_logged_in
    redirect_to profile_path, warning: t('defaults.already_logged_in') if logged_in?
  end
end
