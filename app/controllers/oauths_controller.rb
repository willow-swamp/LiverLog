class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at("line")
  end

  def callback
    provider = "line"
    if @user = login_from(provider)
      redirect_to user_path(@user), notice: "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to first_login_path, notice: "Logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, alert: "Failed to login from #{provider.titleize}!"
      end
    end
  end
end
