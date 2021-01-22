class PostsController < ApplicationController
  def show
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
      redirect_to post_path(@post.id)
    else
      @user = current_user
      render action: :index
    end
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end
end
