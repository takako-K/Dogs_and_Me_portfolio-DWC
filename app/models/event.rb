class Event < ApplicationRecord
  belongs_to :user

  validates :start, presence: true
  validates :end, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, length: { maximum: 100 }
end
