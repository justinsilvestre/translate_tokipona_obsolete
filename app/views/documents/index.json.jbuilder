json.array!(@documents) do |document|
  json.extract! document, :id, :user_id, :json
  json.url document_url(document, format: :json)
end
