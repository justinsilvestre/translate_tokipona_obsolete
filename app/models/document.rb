class Document < ActiveRecord::Base
	require 'json'
	include EachHead

  belongs_to :user
  has_many :translations, dependent: :destroy

  validates :title, presence: true
  validates :original_text, presence: true

  before_save :set_tree, :prepare_words, :index_heads

  def set_tree
  	require 'tokipona'
  	self.tree = Parsing.new(original_text).json
  end

  # private

  def index_heads
  end

	def prepare_words
		extraction = []
		JSON.parse(tree).each do |sentence|
			extraction += extract_words(sentence)
		end
		self.words = extraction.join ','
	end

	def parsed_tree
		@parsed_tree ||= JSON.parse(tree)
	end

	def extract_words(collection)
		heads = []
		each_head(collection) do |e|
			heads += extract_words(e)
		end
		heads
	end
end
