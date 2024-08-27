json.extract! invoice, :id, :order_id, :amount, :status, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
