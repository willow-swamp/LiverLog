class Invitees::OauthsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_general

  def oauth
    session[:invite_token] = params[:invite_token]
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to group_path(@user.groups.first), success: "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        @user.role = :invitee
        @group = Group.find_by(invite_token: session[:invite_token])
        @group.save_group_member(@user)
        reset_session
        auto_login(@user)
        redirect_to invitees_invitation_first_login_path, success: "Logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, error: "Failed to login from #{provider.titleize}!"
      end
    end
  end
end
