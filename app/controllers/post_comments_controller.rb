class PostCommentsController < ApplicationController
  def create
    comment = current_user.post_comments.new(post_comment_params)
    if comment.save
      redirect_to group_post_path(comment.post.group, comment.post), success: t('defaults.comment_success')
    else
      redirect_to group_post_path(comment.post.group, comment.post), danger: t('defaults.comment_error')
    end
  end

  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy!
    redirect_to group_post_path(comment.post.group, comment.post), success: t('defaults.comment_delete')
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:message).merge(post_id: params[:post_id])
  end
end
