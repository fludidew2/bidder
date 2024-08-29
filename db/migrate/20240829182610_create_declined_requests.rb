class CreateDeclinedRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :declined_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
