class RenameColumnPosInEnglishPhrases < ActiveRecord::Migration
  def change
  	rename_column :english_phrases, :pos, :role
  end
end
