class EnglishPhrase < ActiveRecord::Base
  include GrammarHelper

  belongs_to :tokipona_phrase
  belongs_to :user

  after_initialize :inflect
  # before?after delete, delete tokipona phrase if this was its only translation

  # most uses first, then most upvotes. or switched?
  default_scope { order('uses') }


  def increment_uses
  	self.uses += 1
  end

  def decrement_uses
  	self.uses -= 1
  end

  def self.from_tokipona(tp_id, practical_role=nil)
    EnglishPhrase.where("tokipona_phrase_id = ?", tp_id)
  end

  private

  	def inflect
  	end
end
