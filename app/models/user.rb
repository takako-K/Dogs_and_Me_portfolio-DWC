class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :events, dependent: :destroy
  # 自分が作成した通知（active）、通知を送ったユーザーIDを参考にモデルへアクセス
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  # 自分宛の通知（passive）、通知を送られたユーザーIDを参考にモデルへアクセス
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 100 }
end
