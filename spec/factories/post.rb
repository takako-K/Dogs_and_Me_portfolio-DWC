FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 50) }
    association :user, factory: :user            # アソシエーション
    association :post_comment, factory: :post_comment
    association :notification, factory: :notification
    association :favorite, factory: :favorite
  end
end