class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :tags, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  attachment :post_image

  validates :post_image, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 300 }

  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "favorite"
    )
    notification.save if notification.valid?
  end

  def create_notification_post_comment!(current_user, post_comment_id)
    # 自分以外にコメントしている人を全て取得し、全員に通知を送る
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_post_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_post_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    # コメントは複数回することが考えられる為、一つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )
    # 自分の投稿に対するコメントの場合は通知済に設定
    notification.checked = true if notification.visiter_id == notification.visited_id
    notification.save if notification.valid?
  end
end
