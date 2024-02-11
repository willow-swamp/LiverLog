class CommunityPostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  skip_before_action :require_general, only: %i[index show]
  before_action :set_user, only: %i[index new create edit update destroy]
  before_action :set_community_post, only: %i[show edit update destroy]

  def index
    @community_posts = CommunityPost.includes(:user).order(created_at: :desc)
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

  def show
    @community_post_comment = CommunityPostComment.new
    @community_post_comments = @community_post.community_post_comments.includes(:user).order(created_at: :desc)
  end

  def edit
    authorize_user(@community_post, @user)
  end

  def update
    authorize_user(@community_post, @user)
    if @community_post.update(community_post_params)
      flash[:success] = t '.success'
      redirect_to community_posts_path
    else
      flash.now[:danger] = t '.error'
      render :edit
    end
  end

  def destroy
    authorize_user(@community_post, @user)
    @community_post.destroy!
    flash[:success] = t '.success'
    redirect_to community_posts_path
  end

  private

  def community_post_params
    params.require(:community_post).permit(:content, :image)
  end

  def set_community_post
    @community_post = CommunityPost.find(params[:id])
  end

  def set_user
    @user = (current_user if logged_in?)
  end

  def authorize_user(community_post, user)
    return if community_post.user == user

    flash[:danger] = t 'defaults.access_denied'
    redirect_to community_posts_path
  end
end
