class AddWordsToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :words, :text
  end
end
