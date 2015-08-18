json.array!(@english_phrases) do |english_phrase|
  json.extract! english_phrase, :id, :base_form, :role, :forms
end
