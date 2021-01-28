class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :post_comment, presence: true, length: { maximum: 200 }
end
