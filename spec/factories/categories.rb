FactoryBot.define do
  factory :category do
    name { "category name" }
    image { Rack::Test::UploadedFile.new('app/assets/images/database_seed/all.jpg', 'image/jpg') }
  
    trait :invalid do 
      name { "" }
      image { nil }
    end
  end
end

def category_with_food_items(food_items_count: 5) 
  FactoryBot.create(:category) do |category|
    FactoryBot.create_list(:food_item, food_items_count, category: category)
  end
end