class CreateBids < ActiveRecord::Migration[7.0]
  def change
    create_table :bids do |t|
      t.references :vendor, null: false, foreign_key: true
      t.references :request, null: false, foreign_key: true
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
