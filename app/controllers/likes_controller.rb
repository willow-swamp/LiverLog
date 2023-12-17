class LikesController < ApplicationController
  skip_before_action :require_general, only: %i[create destroy]

  def create
    post = Post.find params[:post_id]
    current_user.like_post(post)
    redirect_to group_post_path(params[:group_id], params[:post_id]), success: t('defaults.like_post')
  end

  def destroy
    post = Post.find params[:post_id]
    current_user.unlike_post(post)
    redirect_to group_post_path(params[:group_id], params[:post_id]), success: t('defaults.unlike_post')
  end
end
