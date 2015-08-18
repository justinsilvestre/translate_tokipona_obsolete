class Translation < ActiveRecord::Base
  require 'json'
  include GrammarHelper
  include EachHead

  belongs_to :user
  belongs_to :document
  has_many :segments, class_name: 'TranslationSegment', dependent: :destroy

  after_initialize :prepare_analysis
  after_save :create_translation_segments

  validate :analysis_must_be_in_proper_format

  private

  def words_array
    document.words.split ','
  end

  def prepare_analysis
    # self.analysis = scaffold_translations(document.parsed_tree).to_json
    self.analysis = document.parsed_tree.map { |sentence|
      scaffold_translations(sentence)
    }.to_json
  end

  def get_role(head_parent)
    return 't' if head_parent.keys.include?('direct_objects')
    return 'prep' if head_parent.keys.include?('prepositional_object')
    return 'i'
  end

  # check for erroneously capitalize tp words eventually.
  def scaffold_translations(the_tree)
    translations = []
    each_head(the_tree) do |tp_word, parent|
      if native_tokipona?(tp_word)
        role = get_role(parent)
        # tp = TokiponaPhrase.find_by(words: principal_tokipona_form(tp_word), role: role) # ACCOUNT FOR ROLE
        tp = TokiponaPhrase.where('words = ?', principal_tokipona_form(tp_word)).find_in_role(role).first
      else
        # make or find proper noun
        tp = TokiponaPhrase.find_or_create_by(words: tp_word.capitalize, role: 'i')
      end
      byebug if tp.nil?
      english_phrase = EnglishPhrase.find_by(tokipona_phrase_id: tp.id)

      translations.push(
        tp: tp.words,
        tp_role: tp.role,
        tp_id: tp.id,
        en: english_phrase.nil? ? nil : english_phrase.base_form,
        en_id: english_phrase.nil? ? nil : english_phrase.id
        )
    end
    translations
  end

  def create_translation_segments
    # safe_segments.each do |segment|
    #   segments.create(place: segment[0], english_phrase_id: segment[1], english_form: segment[2])
    # end
  end

  def analysis_array
    if translation_segments.is_a? Array
      translation_segments
    else
      JSON.parse translation_segments
    end
  end

  def analysis_must_be_in_proper_format
  end

end
