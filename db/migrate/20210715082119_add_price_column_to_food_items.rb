class AddPriceColumnToFoodItems < ActiveRecord::Migration[6.1]
  def change
    add_column :food_items, :price, :integer
  end
end
