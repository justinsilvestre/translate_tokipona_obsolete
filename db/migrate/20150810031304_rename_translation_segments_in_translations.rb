class RenameTranslationSegmentsInTranslations < ActiveRecord::Migration
  def change
  	rename_column :translations, :translation_segments, :analysis
  end
end
