class AddAcceptedAndBiddingClosedToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :accepted, :boolean
    add_column :requests, :bidding_closed, :boolean
  end
end
