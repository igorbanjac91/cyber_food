class Category < ApplicationRecord

  validates :name, presence: true
  validates :name, length: { maximum: 30 }

  has_many :food_items

  has_one_attached :image
end
