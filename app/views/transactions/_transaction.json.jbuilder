json.extract! transaction, :id, :share, :price, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
