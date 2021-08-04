class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items

  def total
    order_items.reduce(0) do |sum, order_item|
      sum + order_item.food_item.price * order_item.quantity
    end
  end
end

