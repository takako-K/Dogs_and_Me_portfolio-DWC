class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    # redirect_to request.referer     # 元の画面に遷移する（非同期化した為不要）
    # 通知の作成
    @post.create_notification_by(current_user_id)
    respond_to do |format|
      format.html {redirect_to request.referer}
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    # redirect_to request.referer     # 元の画面に遷移する（非同期化した為不要）
  end
end
