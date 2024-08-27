json.extract! request, :id, :buyer_id, :description, :status, :created_at, :updated_at
json.url request_url(request, format: :json)
