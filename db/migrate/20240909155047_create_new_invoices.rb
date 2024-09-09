class CreateNewInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :request, null: false, foreign_key: true
      t.references :bid, null: false, foreign_key: true
      t.string :request_description
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
