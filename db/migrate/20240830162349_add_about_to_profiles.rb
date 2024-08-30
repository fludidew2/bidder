class AddAboutToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :about, :text
  end
end
