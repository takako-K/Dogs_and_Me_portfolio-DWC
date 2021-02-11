class NotificationsController < ApplicationController
  def index
    @user = current_user
    @events = Event.where(user_id: current_user.id)
    # サイドバーに本日の予定表示
    @today_events = @events.where("start <= ? AND end >= ?", Date.today.end_of_day, Date.today.beginning_of_day)
    # current_userの投稿に紐づいた通知一覧
    @notifications = current_user.passive_notifications
    # @notificationの中でまだ確認していない（indexに一度も遷移していない）通知のみ
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy_all
    # 通知を全削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path(current_user.id)
  end
end
