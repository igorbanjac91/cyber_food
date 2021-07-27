class FoodItem < ApplicationRecord

  validates :name, :description, presence: true
  validates :price, presence: true

  has_many :order_items
  belongs_to :category, optional: true

  has_one_attached :image
end
