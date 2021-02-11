class Notification < ApplicationRecord
  # スコープ（新着順）
  default_scope -> { order(created_at: :desc) }

  # optional: trueはpost_idにnilを許可する為（belongs_toがつくカラムには自動的にallow_nil: falseが付与される）
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  # 通知を送ったユーザーIDを参考にモデルへアクセス
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id',  optional: true
  # 通知を送られたユーザーIDを参考にモデルへアクセス
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id',  optional: true
end
