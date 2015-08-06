class Translation < ActiveRecord::Base
	require 'json'
  require_relative '../../lib/word_list'

  belongs_to :user
  belongs_to :document
  has_many :segments, class_name: 'TranslationSegment', dependent: :destroy

  after_initialize :prepare_segments
  after_save :create_translation_segments

  # translation_segments is attribute in database
  validate :translation_segments_must_be_in_proper_array_format

  def javascript_object
    { skeleton: JSON.parse(document.json) }.to_json 
  end

  private

  def prepare_segments
    words = document.words.split ','
    self.translation_segments = words.map do |word|
      [ ]
    end
  end

  def filter_proper_nouns(word)
    if TOKIPONA_WORDS.keys.include? word
      return word
    elsif pn = ProperNoun.find_by(form: word.capitalize)
      return pn.id
    else
      ProperNoun.create(form: word.capitalize)
    end
  end

  def create_translation_segments
    safe_segments.each do |segment|
      segments.create(place: segment[0], english_phrase_id: segment[1], english_form: segment[2])
    end
  end

  def safe_segments
    if translation_segments.is_a? Array
      translation_segments
    else
      JSON.parse translation_segments
    end
  end

  def translation_segments_must_be_in_proper_array_format
    if safe_segments.any? { |s| !(s.is_a? Array) || s.length != 3 }
      errors.add(:translation_segments, "must be in proper format")
    end
  end

end
