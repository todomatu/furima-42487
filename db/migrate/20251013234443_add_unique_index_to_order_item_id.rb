class AddUniqueIndexToOrderItemId < ActiveRecord::Migration[7.1]
  def change
    add_index :orders, :item_id, unique: true,name: 'unique_index_orders_on_item_id'
  end
end
