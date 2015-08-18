class RenameJcolumnJsonInDocuments < ActiveRecord::Migration
  def change
  	rename_column :documents, :json, :tree
  end
end
