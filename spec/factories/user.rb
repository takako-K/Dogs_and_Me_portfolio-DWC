FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 30) }
    password { 'password' }
    password_confirmation { 'password' }
    association :post, factory: :post            # アソシエーション
    association :event, factory: :event
    association :post_comment, factory: :post_comment
    association :notification, factory: :notification
    association :favorite, factory: :favorite
  end
end