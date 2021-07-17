json.extract! category, :id, :name, :created_at, :updated_at
if category.image.attached?
  json.image_url url_for(category.image)
end