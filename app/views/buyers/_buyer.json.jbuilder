json.extract! buyer, :id, :name, :email, :address, :phone_number, :created_at, :updated_at
json.url buyer_url(buyer, format: :json)
