class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:top]
  before_action :set_user, only: [:first_login]
  before_action :first_login?, only: [:first_login]

  def top
  end

  def first_login
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def first_login?
    if !@user.first_login
      redirect_to profile_path
    end
  end
end
