FactoryBot.define do
  factory :event do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 50) }
    association :user, factory: :user
  end
end
