class FixForeignKeyForBids < ActiveRecord::Migration[7.0]
  def change
    # Remove the incorrect foreign key
    remove_foreign_key :bids, column: :user_id, to_table: :vendors if foreign_key_exists?(:bids, column: :user_id, to_table: :vendors)

    # Add the correct foreign key
    add_foreign_key :bids, :users, column: :user_id unless foreign_key_exists?(:bids, column: :user_id, to_table: :users)
  end
end
