json.extract! invoice, :id, :notes, :term, :status, :client_id, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
