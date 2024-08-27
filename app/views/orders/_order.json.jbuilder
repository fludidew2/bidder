json.extract! order, :id, :vendor_id, :buyer_id, :request_id, :total, :status, :created_at, :updated_at
json.url order_url(order, format: :json)
