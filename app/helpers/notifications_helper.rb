module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @post_comment = nil
    @your_post = link_to 'あなたの投稿', post_path(notification.post_id), style: "font-weight: bold;"
    @visiter_post_comment = notification.post_comment_id
    # notification.actionの種類が、favoriteかpost_commentかで分岐
    case notification.action
    when "favorite"
      tag.a(notification.visiter.name, href: user_path(@visiter), style: 'font-weight: bold;') + "が" + tag.a("あなたの投稿", href: post_path(notification.post_id), style: 'font-weight: bold;') + "にいいねしました。"
    when "post_comment"
      @post_comment = PostComment.find_by(id: @visiter_post_comment)&.comment
      tag.a(@visiter.name, href: user_path(@visiter), style: 'font-weight: bold;') + "が" + tag.a("あなたの投稿", href: post_path(notification.post_id), style: 'font-weight: bold;') + "にコメントしました。"
    end
  end

  # 未確認の通知
  def unchecked_notifications
    current_user.passive_notifications.where(checked: false)
  end
end
