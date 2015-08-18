require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@doc1 = Document.create(title: 'tomo palisa suli pi nimi Pape',
  		original_text: 'ma ali li jo e toki wan sama. jan ali li kama tan ni: nasin pi kama suno li kama lon ma Sinale li awen lon ni. jan li toki e ni: o kama! mi mute o pali e kiwen tomo o seli e ona. jan mute li toki e ni: o kama! mi mute o pali e ma tomo e tomo palisa suli. lawa pi tomo palisa li lon sewi kon. nimi pi mi mute o kama suli! mi wile ala e ni: mi mute li weka. mi mute li lon ma ali. jan sewi Jawe li kama anpa li lukin e ma tomo e tomo palisa pi jan lili mute. jan sewi Jawe li toki e ni: jan ni li jo e ma wan li jo e toki sama li pali e tomo palisa. tenpo ni la ona mute li ken pali mute ike. mi wile tawa anpa. mi pakala e toki pi jan mute ni. jan o sona ala e toki pi jan ante. jan sewi Jawe li pali e ni: jan ali li poki ala jan li lon ma mute li ken ala pali e ma tomo. nimi pi ma tomo ni li Pape tan ni: jan sewi Jawe li pakala e toki pi jan ali. tan ma tomo Pape la jan sewi Jawe li tawa e jan tawa ma mute.')
  	@translation1 = doc1.translations.new
  end

end
