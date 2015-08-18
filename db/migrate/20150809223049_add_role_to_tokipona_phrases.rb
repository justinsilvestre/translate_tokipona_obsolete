class AddRoleToTokiponaPhrases < ActiveRecord::Migration
  def change
  	add_column :tokipona_phrases, :role, :string
  	add_index :tokipona_phrases, [:words, :role], unique: true
  end
end
