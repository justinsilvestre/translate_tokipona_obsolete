class CreateTranslationSegments < ActiveRecord::Migration
  def change
    create_table :translation_segments do |t|
      t.references :translation, index: true, foreign_key: true
      t.integer :place
      t.references :english_phrase, index: true, foreign_key: true
      t.string :english_form

      t.timestamps null: false
    end
    add_index :translation_segments, :place
  end
end
