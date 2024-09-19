class AddWinningBidUserIdToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :winning_bid_user_id, :integer
  end
end
