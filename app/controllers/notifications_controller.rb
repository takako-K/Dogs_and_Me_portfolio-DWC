class NotificationsController < ApplicationController
  def index
    @user = current_user
    @today_events = Event.where("start >= ?" && "end >= ?", Date.today).where(user_id: current_user.id)             # eventモデル利用して本日の予定表示
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
