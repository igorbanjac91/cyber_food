class FoodItem < ApplicationRecord

  validates :name, :description, :price, presence: true
  validates :name, length: { maximum: 30 }
  validates :description, length: { maximum: 250 }
  validates :price, numericality: { only_integer: true }

  has_many :order_items
  belongs_to :category

  has_one_attached :image

  after_create do 
    unless Rails.env == "test"
      stripe_product = Stripe::Product.create({
        name: self.name
      })
      stripe_price = Stripe::Price.create({
        product: stripe_product, 
        unit_amount: self.price,
        currency: "usd"
      })
      update(stripe_product_id: stripe_product.id, stripe_price_id: stripe_price.id)
    end
  end

  unless Rails.env == "test" 
    after_update :create_and_assign_new_stripe_price, if: :saved_change_to_price?
  end

  def create_and_assign_new_stripe_price
    unless Rails.env == "test"
      price = Stripe::Price.update(product: self.stripe_product_id, unit_amount: self.price, currency: "usd")
      update(stripe_price_id: price.id)
    end
  end
end
