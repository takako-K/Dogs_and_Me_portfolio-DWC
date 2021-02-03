FactoryBot.define do
  factory :favorite do
    association :user, factory: :user
    association :post, factory: :post
  end
end
