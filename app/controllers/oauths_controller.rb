class OauthsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_general

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      if @user.general?
        redirect_to profile_path, success: t('defaults.login_success')
      elsif @user.invitee?
        redirect_to group_path(@user.groups.first), success: t('defaults.login_success')
      end
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to first_login_path, success: t('defaults.login_success')
      rescue
        redirect_to root_path, error: t('defaults.login_failed')
      end
    end
  end
end
