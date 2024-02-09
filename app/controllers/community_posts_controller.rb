class CommunityPostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  skip_before_action :require_general, only: %i[index show]
  before_action :set_user, only: %i[index new create edit update destroy]

  def index
    @community_posts = CommunityPost.all
  end

  def new
    @community_post = CommunityPost.new
  end

  def create
    @community_post = @user.community_posts.build(community_post_params)
    if @community_post.save
      flash[:success] = t '.success'
      redirect_to community_posts_path
    else
      flash.now[:danger] = t '.error'
      render :new
    end
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def community_post_params
    params.require(:community_post).permit(:content, :image)
  end

  def set_user
    @user = (current_user if logged_in?)
  end
end
