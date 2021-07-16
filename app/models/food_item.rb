class FoodItem < ApplicationRecord

  validates :name, :description, presence: true
  validates :price, :description, presence: true

  has_many :order_items
  belongs_to :category

  has_one_attached :image
end
