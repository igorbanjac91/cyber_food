FactoryBot.define do
  factory :food_item do
    name { "food item name" }
    description { "food item description" }
    price { 5.00 }
    category 
    image { Rack::Test::UploadedFile.new('storage/local/main.jpg', 'image/jpg') }
  end
end
