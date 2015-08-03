class AddOriginalTextToDocument < ActiveRecord::Migration
  def change
  	add_column :documents, :original_text, :text
  end
end
