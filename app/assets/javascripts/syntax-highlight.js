window.syntaxHighlight = function(sentences) {
	var result = '';

	var unpackSubstantive = function(substantive) {
		var result = '';
		if (_.has(substantive, 'interrogative')) {
			result += span('interrogative', span('h',substantive.head) + ' ala ' + substantive.head);
		} else if (_.has(substantive, 'negative')) {
			result += span('h',substantive.head) + span('negative',' ala');
		} else {
			result += span('h',substantive.head);
		}
		if (_.has(substantive, 'complements')) {
			_.each(substantive.complements, function(complement) {
				if (_.has(complement, 'complements')) result += span('pi',' pi');

				result += ' ' + span('complement', unpackSubstantive(complement));
			});
		}
		if (_.has(substantive, 'direct_objects')) {
			result += span('direct-object', unpackDirectObjects(substantive));
		} else if (_.has(substantive, 'prepositional_object')) {
			result += ' ' + unpackSubstantive(substantive.prepositional_object)
		} else if (_.has(substantive, 'gerundive')) {
			result += ' ' + unpackSubstantive(substantive.gerundive);
		}
		return result;
	};

	var unpackContext = function(sentence) {
		var result = '';
		var context = sentence.context;
		context.mood = 'indicative';
		if ( !_.isUndefined(context.subject) ) result += span('subject', unpackSubject(context) + ' ');
		if ( !_.isUndefined(context.predicate) ) result += span('predicate', unpackPredicate(context) + ' ');
		return result;
	};

	var unpackPredicate = function(clause) {
		var result = '';
		var components = clause.predicate;
		_.each(components, function(component, i) {
			if (i > 0) result += ' ';
			if (clause.mood === 'optative') result += span('modal-particle', 'o ');
			if ((clause.mood === 'indicative') && ( (i > 0) || (_.has(clause,'subject') && !hasMicroSubject(clause)) ))
				{ result += span('modal-particle','li '); }
			result += unpackSubstantive(component);
		});
		return result;
	};

	var unpackDirectObjects = function(substantive) {
		var result = '';
		var directObjects = substantive.direct_objects;
		_.each(directObjects, function(directObject) {
			result += span('object-particle',' e ') + unpackSubstantive(directObject);
		});
		return result;
	}

	var hasMicroSubject = function(sentence) {
		return ( _.has(sentence, 'subject') ) &&
			( sentence.subject.components.length === 1 && _.isUndefined(sentence.subject.components[0].complements) ) &&
			( sentence.subject.components[0].head === 'mi' || sentence.subject.components[0].head === 'sina' );
	}

	var unpackSubject = function(sentence) {
		var result = '';
		var components = sentence.subject.components;
		_.each(components, function(component, i) {
			if (i > 0) result += ' en '
			result += unpackSubstantive(component);
		});
		return result;
	}

	var span = function(className, text) { 
		var result = '<span class="' + className + '">' + text + '</span>';
		return result;
	};

	var unpackSentence = function(sentence) {
		var result = '<p class="sentence">'
		if ( !_.isUndefined(sentence.vocative) ) {
			result += span('vocative', unpackSubstantive(sentence.vocative) + ' o');
			if (!_.isUndefined(sentence.predicate)) result += ','
		}
		if ( !_.isUndefined(sentence.taso) ) result += span('context', ' taso');
		if ( !_.isUndefined(sentence.context) ) result += span('context', ' ' + unpackContext(sentence) + span('la',' la'));
		if ( !_.isUndefined(sentence.subject) ) result += span('subject', ' ' + unpackSubject(sentence) + ' ');
		if ( !_.isUndefined(sentence.predicate) ) result += span('predicate', ' ' + unpackPredicate(sentence));
		if ( !_.isUndefined(sentence.emphatic) ) result += span('emphatic', ' ' + sentence.emphatic)
		if ( sentence.end_punctuation != '' ) {
			result += sentence.end_punctuation;
		} else {
			result += '.'
		}
		return result + '</p> '; 
	}

	if (_.isArray(sentences)) {
		_.each(sentences, function(sentence) {
			result += unpackSentence(sentence);
		});

		return result;
	} else {
		return unpackSentence(sentences);
	}
}
