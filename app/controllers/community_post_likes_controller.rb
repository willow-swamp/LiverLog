class CommunityPostLikesController < ApplicationController
  skip_before_action :require_general, only: %i[create destroy]

  def create
    post = CommunityPost.find params[:community_post_id]
    current_user.like_community_post(post)
    redirect_to community_post_path(params[:community_post_id]), success: t('defaults.like_post')
  end

  def destroy
    post = CommunityPost.find params[:community_post_id]
    current_user.unlike_community_post(post)
    redirect_to community_post_path(params[:community_post_id]), success: t('defaults.unlike_post')
  end
end
