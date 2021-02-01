class Event < ApplicationRecord
  belongs_to :user
  # def self.today_events
    # Event.where("start <= ? and end >= ?", Date.today, Date.today)
    # .or()
  # end
end
