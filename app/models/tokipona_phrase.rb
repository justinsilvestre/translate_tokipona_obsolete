class TokiponaPhrase < ActiveRecord::Base
	include GrammarHelper

	has_many :english_phrases

	after_initialize :extract_words

	# only one with identical words and role

	def self.find_in_role(given_role)
		matching_role = self.where("role = ?", given_role)
		return matching_role unless matching_role.empty?
		return self.all
	end

	# types of tp phrases: subject, predicate, complement,
	# direct object, prepositional object, gerundive

	def word_keys(words)
		words.each.map do |word|
			TOKIPONA_WORDS[word.to_s]
		end
	end

	private

		def extract_words
		end
end
