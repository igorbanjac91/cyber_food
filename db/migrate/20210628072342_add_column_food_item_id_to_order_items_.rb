class AddColumnFoodItemIdToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :food_item_id, :bigint
  end
end
