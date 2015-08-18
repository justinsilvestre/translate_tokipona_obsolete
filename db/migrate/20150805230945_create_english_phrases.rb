class CreateEnglishPhrases < ActiveRecord::Migration
  def change
    create_table :english_phrases do |t|
      t.references :tokipona_phrase, index: true, foreign_key: true
      t.string :pos
      t.text :forms
      t.string :base_form
      t.text :forms
      t.references :user, index: true, foreign_key: true
      t.integer :uses
      t.integer :upvotes

      t.timestamps null: false
    end
  end
end
