class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @posts = Post.all
    @user = current_user
    @post_comment = PostComment.new
    @events = Event.where(user_id: current_user.id)
    @today_events = @events.where("start <= ? AND end >= ?", Date.today.end_of_day, Date.today.beginning_of_day)       # eventモデル利用して本日の予定表示
  end

  def index
    @posts = Post.all
    @user = current_user
    @events = Event.where(user_id: current_user.id)
    @today_events = @events.where("start <= ? AND end >= ?", Date.today.end_of_day, Date.today.beginning_of_day)       # eventモデル利用して本日の予定表示
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render "edit"
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "投稿情報の更新に成功しました。"
      redirect_to post_path(@post.id)
    else
      render action: :edit
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @posts = Post.all
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "投稿に成功しました。"
      redirect_to post_path(@post.id)
    else
      @user = current_user
      render action: :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:info] = "投稿を削除しました。"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end
end
