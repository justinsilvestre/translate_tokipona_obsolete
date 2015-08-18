module GrammarHelper

  ROLE_CORRESPONDENCES =  { p: %i'x',
        i: %i'vi n adj adv pns pnp pnsn pnso pnpn pnpo pnin d dp ds',
        t: %i'vt',
        prep: %i'prep vt',
        pred: %i'int pred',
        subj: %i'subj' }

	def english_roles_corresponding_to(tp_role)
      ROLE_CORRESPONDENCES[tp_role.to_sym]
  end

  def tokipona_roles_corresponding_to(en_role)
  	reverse_correspondences = {}
  	ROLE_CORRESPONDENCES.each do |tp, ens|
  		ens.each do |en|
  			reverse_correspondences[en] ||= []
  			reverse_correspondences[en] << tp
  		end
  	end
  	reverse_correspondences[en_role.to_sym]
  end

  # later, account for cases like subjectless predicates?

  TP_ROLE_CASCADING = {
  	subj: %i'i',
  	pred: %i'prev, t, prep, i'
  }

	TOKIPONA_WORDS = 	{ a: :a,
		akesi: :akesi,
		ala: :ala,
		alasa: :alasa,
		ale: :ale,
		ali: :ale,
		anpa: :anpa,
		ante: :ante,
		anu: :anu,
		awen: :awen,
		e: :e,
		en: :en,
		esun: :esun,
		ijo: :ijo,
		ike: :ike,
		ilo: :ilo,
		insa: :insa,
		jaki: :jaki,
		jan: :jan,
		jelo: :jelo,
		jo: :jo,
		kala: :kala,
		kalama: :kalama,
		kama: :kama,
		kasi: :kasi,
		ken: :ken,
		kepeken: :kepeken,
		kili: :kili,
		kin: :a,
		kiwen: :kiwen,
		ko: :ko,
		kon: :kon,
		kule: :kule,
		kulupu: :kulupu,
		kute: :kute,
		la: :la,
		lape: :lape,
		laso: :laso,
		lawa: :lawa,
		len: :len,
		lete: :lete,
		li: :li,
		lili: :lili,
		linja: :linja,
		lipu: :lipu,
		loje: :loje,
		lon: :lon,
		luka: :luka,
		lukin: :lukin,
		lupa: :lupa,
		ma: :ma,
		mama: :mama,
		mani: :mani,
		meli: :meli,
		mi: :mi,
		mije: :mije,
		moku: :moku,
		moli: :moli,
		monsi: :monsi,
		mu: :mu,
		musi: :musi,
		mute: :mute,
		namako: :sin,
		nanpa: :nanpa,
		nasa: :nasa,
		nasin: :nasin,
		nena: :nena,
		ni: :ni,
		nimi: :nimi,
		noka: :noka,
		o: :o,
		oko: :lukin,
		olin: :olin,
		ona: :ona,
		open: :open,
		pakala: :pakala,
		pali: :pali,
		palisa: :palisa,
		pan: :pan,
		pana: :pana,
		pi: :pi,
		pilin: :pilin,
		pimeja: :pimeja,
		pini: :pini,
		pipi: :pipi,
		poka: :poka,
		poki: :poki,
		pona: :pona,
		pu: :pu,
		sama: :sama,
		seli: :seli,
		selo: :selo,
		seme: :seme,
		sewi: :sewi,
		sijelo: :sijelo,
		sike: :sike,
		sin: :sin,
		sina: :sina,
		sinpin: :sinpin,
		sitelen: :sitelen,
		sona: :sona,
		soweli: :soweli,
		suli: :suli,
		suno: :suno,
		supa: :supa,
		suwi: :suwi,
		tan: :tan,
		taso: :taso,
		tawa: :tawa,
		telo: :telo,
		tenpo: :tenpo,
		toki: :toki,
		tomo: :tomo,
		tu: :tu,
		unpa: :unpa,
		uta: :uta,
		utala: :utala,
		walo: :walo,
		wan: :wan,
		waso: :waso,
		wawa: :wawa,
		weka: :weka,
		wile: :wile }

	def native_tokipona?(word)
		TOKIPONA_WORDS.keys.include?(word.to_sym)
	end

	def principal_tokipona_form(word)
		TOKIPONA_WORDS[word.to_sym].to_s
	end
end