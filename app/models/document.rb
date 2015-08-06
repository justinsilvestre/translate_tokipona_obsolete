class Document < ActiveRecord::Base
	require 'json'

  belongs_to :user
  has_many :translations, dependent: :destroy

  validates :title, presence: true
  validates :original_text, presence: true

  before_save :set_json, :prepare_words

  def set_json
  	require 'tokipona'
  	self.json = Parsing.new(original_text).json
  end

  # private

	def prepare_words
		extraction = []
		JSON.parse(json).each do |sentence|
			extraction += extract_words(sentence)
		end
		self.words = extraction.join ','
	end

	def extract_words(collection)
		heads = []
		if collection.is_a? Array
			collection.each do |element|
				heads += extract_words(element)
			end
		else
			collection.each do |k, v|
				if k == 'head'
					heads << v
				elsif (v.is_a? Array) || (v.is_a? Hash)
					heads += extract_words(v)
				end
			end
		end
		heads
	end
end
