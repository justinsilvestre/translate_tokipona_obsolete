class AddIndexToEnglishPhrases < ActiveRecord::Migration
  def change
  	add_index :english_phrases, [:tokipona_phrase_id, :role]
  end
end
