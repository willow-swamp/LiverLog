class CommunityPostCommentsController < ApplicationController
  skip_before_action :require_general, only: %i[create destroy]

  def create
    comment = current_user.community_post_comments.new(community_post_comment_params)
    if comment.save
      redirect_to community_post_path(comment.community_post), success: t('defaults.comment_success')
    else
      redirect_to community_post_path(comment.community_post), danger: t('defaults.comment_error')
    end
  end

  def destroy
    comment = CommunityPostComment.find(params[:id])
    comment.destroy!
    redirect_to community_post_path(comment.community_post), success: t('defaults.comment_delete')
  end

  private

  def community_post_comment_params
    params.require(:community_post_comment).permit(:message).merge(community_post_id: params[:community_post_id])
  end
end
