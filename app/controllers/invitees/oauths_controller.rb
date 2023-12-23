class Invitees::OauthsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_general
  before_action :already_logged_in, only: [:oauth]

  def oauth
    session[:invite_token] = params[:invite_token]
    login_at(params[:provider])
  end

  private
  def already_logged_in
    redirect_to group_path(current_user.groups.first), warning: t('defaults.already_logged_in') if logged_in?
  end
end
