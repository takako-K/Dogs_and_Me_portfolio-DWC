class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    @comment.save!
    # 通知の作成
    @post.create_notification_post_comment!(current_user, @comment.id)
    flash[:success] = "コメントを投稿しました。"
    redirect_to post_path(@post.id)
  end

  def destroy
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    flash[:info] = "コメントを削除しました。"
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
