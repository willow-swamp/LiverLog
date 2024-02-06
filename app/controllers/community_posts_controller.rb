class CommunityPostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  skip_before_action :require_general, only: %i[index show]
  before_action :set_user, only: %i[index new create edit update destroy]

  def index
    @community_posts = CommunityPost.all
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_user
    if logged_in?
      @user = current_user
    else
      @user = nil
    end
  end
end
