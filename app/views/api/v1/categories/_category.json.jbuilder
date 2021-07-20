json.extract! category, :id, :name, :created_at, :updated_at
if category.image.attached?
  json.image_url url_for(category.image)
end
json.food_items do 
  json.array! category.food_items, partial: "api/v1/food_items/food_item", as: :food_item
end