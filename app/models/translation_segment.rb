class TranslationSegment < ActiveRecord::Base
  belongs_to :translation
  belongs_to :english_phrase
end
