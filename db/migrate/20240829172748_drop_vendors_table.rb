class DropVendorsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :vendors
  end

  def down
    create_table :vendors do |t|
      t.string :name
      t.timestamps
    end
  end
end
