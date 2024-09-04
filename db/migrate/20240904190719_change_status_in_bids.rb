class ChangeStatusInBids < ActiveRecord::Migration[7.0]
  def change
    remove_column :bids, :status, :string
    add_column :bids, :status, :integer
  end
end
