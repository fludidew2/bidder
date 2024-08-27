class ChangeBuyerIdInRequests < ActiveRecord::Migration[6.0]
  def change
    change_column_null :requests, :buyer_id, false
  end
end