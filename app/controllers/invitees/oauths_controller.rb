class Invitees::OauthsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_general

  def oauth
    session[:invite_token] = params[:invite_token]
    login_at(params[:provider])
  end
end
