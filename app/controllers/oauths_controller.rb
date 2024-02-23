class OauthsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_general
  skip_before_action :require_first_login

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    invite_token = session[:invite_token] if session[:invite_token].present?
    if @user = login_from(provider)
      if @user.general? || @user.admin?
        if invite_token.present?
          @group = Group.find_by(invite_token:)
          @group.save_group_member(@user)
          redirect_to group_path(@group), success: t('defaults.login_success')
        else
          redirect_to profile_path, success: t('defaults.login_success')
        end
      elsif @user.invitee?
        redirect_to group_path(@user.groups.first), success: t('defaults.login_success')
      end
    else
      begin
        if invite_token.present?
          @user = create_from(provider)
          @user.role = :invitee
          group = Group.find_by(invite_token:)
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
      rescue StandardError
        redirect_to root_path, error: t('defaults.login_failed')
      end
    end
  end
end
