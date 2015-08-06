class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :document, index: true, foreign_key: true
      t.text :translation_segments

      t.timestamps null: false
    end
  end
end
