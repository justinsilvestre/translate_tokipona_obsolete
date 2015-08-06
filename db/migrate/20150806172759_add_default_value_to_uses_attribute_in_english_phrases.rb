class AddDefaultValueToUsesAttributeInEnglishPhrases < ActiveRecord::Migration
  def change
  	change_column :english_phrases, :uses, :integer, default: 0
  end
end
