class Invitees::OauthsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_general
  skip_before_action :require_first_login

  def oauth
    session[:invite_token] = params[:invite_token]
    login_at(params[:provider])
  end
end
