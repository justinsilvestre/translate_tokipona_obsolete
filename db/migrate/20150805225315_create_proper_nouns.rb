class CreateProperNouns < ActiveRecord::Migration
  def change
    create_table :proper_nouns do |t|
      t.string :form

      t.timestamps null: false
    end

    add_index :proper_nouns, :form, unique: true
  end
end
