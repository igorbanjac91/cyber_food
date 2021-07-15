FactoryBot.define do
  factory :food_item do
    name { "food item name" }
    description { "food item description" }
    price { 5.00 }
    category
  end
end
