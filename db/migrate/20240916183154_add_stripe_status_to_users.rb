class AddStripeStatusToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stripe_status, :integer, default: 0, null: false
  end
end
