class AddSourceAndUrlToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :source, :string
    add_column :documents, :url, :string
  end
end
