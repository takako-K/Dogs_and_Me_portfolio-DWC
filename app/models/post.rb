class Post < ApplicationRecord

  belongs_to :user, optional: true

  attachment :post_image
end
