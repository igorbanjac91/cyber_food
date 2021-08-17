FactoryBot.define do
  factory :food_item do
    association :category
    sequence(:name) { |n| "food_item_#{n}" }
    description { "food item description" }
    price { 500 }
    image { Rack::Test::UploadedFile.new('app/assets/images/database_seed/all.jpg', 'image/jpg') }

    trait :invalid do 
      name { nil }
      description { nil }
      price { nil }
      image { nil }
    end
  end
end
