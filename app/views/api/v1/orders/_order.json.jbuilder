json.extract! order, :id, :user_id, :created_at, :updated_at
json.order_items do 
  json.array! order.order_items, partial: "api/v1/order_items/order_item", as: :order_item
end