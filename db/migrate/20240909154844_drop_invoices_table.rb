class DropInvoicesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :invoices
  end
end
