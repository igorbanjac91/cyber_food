class AddColumnToFoodItems < ActiveRecord::Migration[6.1]
  def change
    add_column :food_items, :category_id, :integer
  end
end
