# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require_relative '../lib/word_list.rb'

tokipona_phrases = TokiponaPhrase.create(TOKIPONA_WORDS.values.uniq.map do |words|
		{ words: "#{word}", length: 1 }
	end)