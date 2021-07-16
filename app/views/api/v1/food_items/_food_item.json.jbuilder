json.extract! food_item, :id, :name, :description, :price, :category_id, :created_at, :updated_at
if food_item.image.attached?
  json.image_url url_for(food_item.image)
end
