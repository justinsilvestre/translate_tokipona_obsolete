class TranslationSegment < ActiveRecord::Base
  belongs_to :translation
  belongs_to :english_phrase

  after_save :increment_english_phrase_uses
  after_destroy :decrement_english_phrase_uses

  validate :user_must_match_translation_user
  validate :english_phrase_must_exist_in_database

  private

  def user_must_match_translation_user

  end

  def english_phrase_must_exist_in_database
  	if EnglishPhrase.find(english_phrase_id).nil?
  		errors.add(:english_phrase, "must exist in the database")
  	end
  end


  def increment_english_phrase_uses
  	english_phrase.increment_uses
  end

  def decrement_english_phrase_uses
  	english_phrase.decrement_uses
  end
end
