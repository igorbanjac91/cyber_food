class FoodItem < ApplicationRecord

  validates :name, :description, presence: true

  has_many :order_items
  belongs_to :category
end
