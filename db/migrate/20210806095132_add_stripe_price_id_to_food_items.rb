class AddStripePriceIdToFoodItems < ActiveRecord::Migration[6.1]
  def change
    add_column :food_items, :stripe_price_id, :string
  end
end
