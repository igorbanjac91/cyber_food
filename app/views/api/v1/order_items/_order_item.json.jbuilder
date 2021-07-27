json.extract! order_item, :id, :food_item_id, :order_id, :created_at, :updated_at
json.food_item do 
  json.extract! order_item.food_item, :id, :name, :description, :price, :category_id, :created_at, :updated_at
end