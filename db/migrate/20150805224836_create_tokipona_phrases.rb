class CreateTokiponaPhrases < ActiveRecord::Migration
  def change
    create_table :tokipona_phrases do |t|
      t.text :words
      t.integer :length
      t.text :full_form

      t.timestamps null: false
    end

    add_index :tokipona_phrases, :words, unique: true
  end
end
