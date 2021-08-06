class FoodItem < ApplicationRecord

  validates :name, :description, presence: true
  validates :price, presence: true

  has_many :order_items
  belongs_to :category, optional: true

  has_one_attached :image

  after_create do 
    stripe_product = Stripe::Product.create({
      name: self.name
    })
    stripe_price = Stipe::Price.create({
      product: stripe_product, 
      unit_amount: self.price,
      currency: "usd"
    })
    update(stripe_product_id: stripe_product.id, stripe_price_id: price.id)
  end

  after_update :create_and_assign_new_stripe_price, if :saved_change_to_price?

  def create_and_assign_new_stripe_price
    price = Stripe::Price.update(product: self.stripe_product_id, unit_amount: self.price, currency: "usd")
    update(stripe_price_id: price.id)
  end
end
