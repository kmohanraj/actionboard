json.extract! client, :id, :name, :email, :address, :company, :comapny_id, :created_at, :updated_at
json.url client_url(client, format: :json)
