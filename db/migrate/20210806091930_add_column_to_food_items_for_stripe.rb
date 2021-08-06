
class AddColumnToFoodItemsForStripe < ActiveRecord::Migration[6.1]
  def change
    add_column :food_items, :stripe_product_id, :string
  end
end
