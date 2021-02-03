FactoryBot.define do
  factory :notification do
    association :post, factory: :post
    association :post_comment, factory: :post_comment
    association :user, factory: :user
  end
end