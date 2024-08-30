class UpdateProfiles < ActiveRecord::Migration[7.0]
  def change
    change_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :email_address

      t.remove :address
    end
  end
end
