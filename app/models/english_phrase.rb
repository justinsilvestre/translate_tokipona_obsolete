class EnglishPhrase < ActiveRecord::Base
  belongs_to :tokipona_phrase
  belongs_to :user

  def increment_uses
  	self.uses += 1
  end

  def decrement_uses
  	self.uses -= 1
  end
end
