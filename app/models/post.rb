class Post < ApplicationRecord

  belongs_to :user, optional: true

  attachment :post_image

  validates :post_image, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 300}
end
