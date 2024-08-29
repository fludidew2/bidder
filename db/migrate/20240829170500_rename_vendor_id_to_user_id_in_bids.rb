class RenameVendorIdToUserIdInBids < ActiveRecord::Migration[6.1]
  def change
    # Rename the column
    rename_column :bids, :vendor_id, :user_id

    # Check if the index exists before removing it
    if index_exists?(:bids, :vendor_id, name: "index_bids_on_vendor_id")
      remove_index :bids, name: "index_bids_on_vendor_id"
    end

    # Check if the new index already exists before adding it
    unless index_exists?(:bids, :user_id, name: "index_bids_on_user_id")
      add_index :bids, :user_id
    end
  end
end