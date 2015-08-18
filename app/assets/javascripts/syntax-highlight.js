app.controller('showDocumentController', ['$scope', 'documentAnalysis', function($scope, documentAnalysis, syntaxHighlight) {
	$scope.documentAnalysis = documentAnalysis;

	this.documentAnalysis = documentAnalysis;
	
}]);

app.directive('tpSentence', function() {
	return {
		scope: { sen: '=' },
		template:
		'<p class="sentence">\
			<span class="vocative" ng-if="sen.vocative">{{ sen.vocative }} o</span>\
			<span class="context" ng-if="sen.taso">taso</span>\
			<span class="context" ng-if="sen.context"><tp-clause clause="sen.context"></tp-clause> la</span>\
			<span class="question-tag" ng-if="sen.question_tag">{{ sen.question_tag }}</span>\
			<tp-clause clause="sen"></tp-clause><span class="emphatic" ng-if="sen.emphatic"> {{ sen.emphatic }}</span>\
			<span class="end-punct" ng-if="sentence.end_punctuation != \'\'">{{ sen.end_punctuation }}</span>\
		</p> '
	}
});


// DON'T FORGET ABOUT D.O./P.O. of GERUNDIVE!!
// also negative/interrogative
app.directive('tpClause', function() {
	return {
		scope: { clause: '=' },
		template:
		'<span class="subject" ng-repeat="substantive in clause.subject.components" ng-include="\'substantiveTemplate\'"></span>\
		<span class="predicate" ng-repeat="substantive in clause.predicate" ng-init="substantive.kind = \'predicate\'" ng-include="\'substantiveTemplate\'"></span>',
		link: function(scope, el, attrs) {
			scope.hasMicroSubject = function(clause) {
				return ( _.has(clause, 'subject') ) &&
				( clause.subject.components.length === 1 && _.isUndefined(clause.subject.components[0].complements) ) &&
				( clause.subject.components[0].head === 'mi' || clause.subject.components[0].head === 'sina' );
			};
			scope.modalParticle = function(clause) {
				if (typeof clause.mood === 'undefined' || clause.mood === 'indicative') {
					return 'li';
				} else {
					return 'o';
				}
			}
		}
	};
});

app.directive('tpSubstantive', function() {
	return {
		scope: { h: '=' },
		template:
		'<span class="h">{{ h.head }}</span>\
		<span ng-include="\'substantiveTemplate\'" ng-repeat="substantive in h.complements"></span>',
	};
});
