class Category < ApplicationRecord
  validates :name, presence: true

  has_many :food_items

  has_one_attached :image
end
