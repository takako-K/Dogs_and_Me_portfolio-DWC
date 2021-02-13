FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 50) }
    post_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg')) }
    association :user, factory: :user            # アソシエーション
  end
end
