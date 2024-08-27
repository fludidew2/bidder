class DropBuyersTableAndRemoveReferences < ActiveRecord::Migration[6.0]
  def change
    # Drop the buyers table
    drop_table :buyers

    # Remove buyer_id references from other tables
    remove_column :orders, :buyer_id
    remove_column :requests, :buyer_id
  end
end