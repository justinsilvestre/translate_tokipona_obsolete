class EnglishPhrasesController < ApplicationController
	def from_tokipona
		@english_phrases = EnglishPhrase.from_tokipona(params[:tokipona_phrase_id], params[:practical_role])
	end
end
