FactoryBot.define do
  factory :post_comment do
    comment { Faker::Lorem.characters(number: 50) }
    association :user, factory: :user
    association :post, factory: :post
  end
end
