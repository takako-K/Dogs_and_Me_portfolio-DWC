class EventsController < ApplicationController
  def show
    @event = Event.new
    @user = current_user
    @events = Event.where(user_id: current_user.id)
  end

  def json
    @events = Event.where(user_id: params[:user_id])
  end

  def index
    @event = Event.new
    @user = current_user
    @events = Event.where(user_id: current_user.id)
    @today_events = Event.where("start >= ?" && "end >= ?", Date.today)             # eventモデル利用して本日の予定表示
  end

  def create
    @user = current_user
    event = Event.new(event_params)
    event.save!
    flash.now[:success] = "予定を登録しました"            # リダイレクトさせればメッセージ出力？
    @events = Event.where(user_id: current_user.id)
  end

  def update
    event = Event.find(params[:id])
    @events = Event.where(user_id: current_user.id)
    event.update(event_params)
    flash.now[:success] = "予定を更新しました"
  end

  def destroy
    @user = current_user
    event = Event.find(params[:id])
    event.destroy
    flash[:info] = "予定を削除しました"
    redirect_to user_events_path(@user)
  end

  private

  def event_params
    params.require(:event).permit(:user_id, :title, :body, :allday, :start, :end)
  end
end
