class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  skip_before_action :require_general, only: %i[show likes]

  def show
    @group = @post.group
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.includes(:user).order(created_at: :desc)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
