app.factory('tokiponaEnglish', ['$http', 'heads', function($http, heads) {
	var service = {}

	var eachHead = heads.each;

	service.Fragment = function(enObj, sentenceIndex, headIndex, doc) {
		var fragment = this;
		fragment.info = enObj;
		fragment.sentenceIndex = sentenceIndex;
		fragment.headIndex = headIndex;
		fragment.editing = false;
		fragment.highlighted = false;

		var counterpart;
		var headCount = 0;
		eachHead(doc[sentenceIndex], function(currentHead, currentHeadParent) {
			if (headIndex === headCount) {
				counterpart = currentHeadParent
			}
			headCount += 1;
		})
		fragment.counterpart = counterpart;

		fragment.translated = function() {
			return fragment.info.en ? fragment.info.en : '?';
		}

		fragment.isAt = function(sen, head) {
			return fragment.identifier()[0] === sen && fragment.identifier()[1] === head;
		}

		fragment.getEnglishChoices = function(tp_id) {
			$http.get('/tp_en/' + tp_id).success(function(data) {
				var currentRole;
				fragment.englishPhrases = data;
				fragment.phrasesByRole = {}
				_.each(fragment.englishPhrases, function(phraseInfo) {
					currentRole = phraseInfo.role
					fragment.phrasesByRole[currentRole] = fragment.phrasesByRole[currentRole] ? fragment.phrasesByRole[currentRole] : [];
					fragment.phrasesByRole[currentRole].push(phraseInfo);
				})
			});
		};


		fragment.startEditing = function() {
			fragment.editing = true;
			console.log(fragment.editing);
			fragment.englishPhrases = fragment.getEnglishChoices(fragment.info.tp_id);
		};
		fragment.stopEditing = function () {
			fragment.editing = false;
			console.log(fragment.editing)
		};

    fragment.highlightCounterpart = function() {
      fragment.highlighted = true;
      fragment.counterpart.highlighted = true;
    };

    fragment.endHighlight = function() {
    	fragment.highlighted = false;
    	fragment.counterpart.highlighted = false;
    };
	};


	service.mappings = function(analysis, doc) {
		var mappings = [];
		var fragments;

		mappings.fragmentAt = function(sen, head) {
			return mappings[sen].fragments[head]
		}

		// one behavior if given array of translation segments.
		// other array if given array of translation segment components

		for (var i = 0; i < analysis.length; i++) {
			fragments = []
			for (var j = 0; j < analysis[i].length; j++) {
				fragments[j] = new service.Fragment(analysis[i][j], i, j, doc);
			}
			mappings[i] = { tp: doc[i], fragments: fragments };
		}


		return mappings;
	}

	return service;
}]);