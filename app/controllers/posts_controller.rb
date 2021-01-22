class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @posts = Post.all
    @user = current_user
  end

  def index
    @posts = Post.all
    @user = current_user
  end

  def edit
  end

  def update
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
      render action: :index
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
