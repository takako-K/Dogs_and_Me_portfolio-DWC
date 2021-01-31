class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @today_events = Event.where("start >= ?" && "end >= ?", Date.today).where(user_id: current_user.id)              # eventモデル利用して本日の予定表示
  end

  def index
    @users = User.all
    @user = current_user
    @today_events = Event.where("start >= ?" && "end >= ?", Date.today).where(user_id: current_user.id)              # eventモデル利用して本日の予定表示
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザー情報の更新に成功しました。"
      redirect_to user_path(@user.id)
    else
      render action: :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :start, :end)
  end
end
