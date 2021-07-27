FactoryBot.define do
  factory :food_item do
    association :category
    name { "food item name" }
    description { "food item description" }
    price { 5.00 }
    image { Rack::Test::UploadedFile.new('storage/local/main.jpg', 'image/jpg') }

    trait :invalid do 
      name { nil }
      description { nil }
      price { nil }
      image { nil }
    end
  end
end
