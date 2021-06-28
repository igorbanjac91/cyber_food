class FoodItem < ApplicationRecord

  validates :name, :description, presence: true

  has_many :order_items
end
