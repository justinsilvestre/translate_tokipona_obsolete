class EnglishPhrase < ActiveRecord::Base
  belongs_to :tokipona_phrase
  belongs_to :user
end
