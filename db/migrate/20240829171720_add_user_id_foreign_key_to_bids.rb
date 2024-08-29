class AddUserIdForeignKeyToBids < ActiveRecord::Migration[7.0]
  def change
    # Ensure the user_id column exists
    add_column :bids, :user_id, :integer unless column_exists?(:bids, :user_id)

    # Add the foreign key constraint
    add_foreign_key :bids, :users, column: :user_id
    add_index :bids, :user_id unless index_exists?(:bids, :user_id)
  end
end
