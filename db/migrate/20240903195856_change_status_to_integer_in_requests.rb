class ChangeStatusToIntegerInRequests < ActiveRecord::Migration[7.0]
  def change
    remove_column :requests, :status, :string
    add_column :requests, :status, :integer, default: 0
  end
end