json.array!(@translations) do |translation|
  json.extract! translation, :id, :user_id, :document_id, :translation_segments
  json.url translation_url(translation, format: :json)
end
