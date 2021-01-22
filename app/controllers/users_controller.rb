class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.all
    @user = current_user
  end

  def edit
  end

  def update
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
