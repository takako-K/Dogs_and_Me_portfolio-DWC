class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # 新着順に５件ずつ表示
    @posts = @user.posts.page(params[:page]).per(5).reverse_order
    @events = Event.where(user_id: current_user.id)
    # サイドバーに本日の予定表示
    @today_events = @events.where("start <= ? AND end >= ?", Date.today.end_of_day, Date.today.beginning_of_day)
  end

  def index
    @users = User.all.page(params[:page]).per(10)
    @user = current_user
    @events = Event.where(user_id: current_user.id)
    # サイドバーに本日の予定表示
    @today_events = @events.where("start <= ? AND end >= ?", Date.today.end_of_day, Date.today.beginning_of_day)
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) if @user != current_user
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
