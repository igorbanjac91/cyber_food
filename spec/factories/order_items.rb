FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    food_item
    order 
  end
end
